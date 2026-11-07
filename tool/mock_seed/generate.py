#!/usr/bin/env python3
"""Generates the mock seed JSON in assets/mock/.

Run from the project root:  python3 tool/mock_seed/generate.py

* Deterministic: the same script always produces the same ids and data.
* Ids mirror the backend: catalog items/variants are Mongo ObjectIds (24 hex),
  everything else is a ULID (26 chars, Crockford base32).
* JSON keys are snake_case, exactly like the Laravel API.
* Money is in minor units (pesewas for GHS).
* Images are free placeholders (picsum.photos, pravatar.cc, ui-avatars.com).
  Real blurhashes are computed from small thumbnails, which are cached in
  .dart_tool/mock_seed_cache (needs network on the first run, macOS `sips`).
* Every file carries `generated_at`; the app's SeedLoader shifts all `*_at` /
  `*_on` dates by the whole days elapsed since then, so "today" stays today.
"""

import json
import math
import os
import random
import struct
import subprocess
import time
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime, timedelta, timezone

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
OUT = os.path.join(ROOT, "assets", "mock")
CACHE = os.path.join(ROOT, ".dart_tool", "mock_seed_cache")
GENERATED_AT = datetime(2026, 10, 11, 8, 0, tzinfo=timezone.utc)
CURRENCY = "GHS"

rng = random.Random(20261011)

# --------------------------------------------------------------------------
# Ids
# --------------------------------------------------------------------------
CROCKFORD = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"


def ulid(at=None):
    ms = int((at or GENERATED_AT - timedelta(days=rng.randint(30, 400))).timestamp() * 1000)
    value = (ms << 80) | rng.getrandbits(80)
    return "".join(CROCKFORD[(value >> (5 * i)) & 31] for i in reversed(range(26)))


_oid_counter = rng.randint(0, 0xFFFFFF)


def object_id():
    global _oid_counter
    _oid_counter = (_oid_counter + 1) & 0xFFFFFF
    ts = int((GENERATED_AT - timedelta(days=rng.randint(30, 300))).timestamp())
    return f"{ts:08x}{rng.getrandbits(40):010x}{_oid_counter:06x}"


def iso(dt):
    return dt.astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def day(dt):
    return dt.strftime("%Y-%m-%d")


def at(month, d, hour=0, minute=0, year=2026):
    # Accra is UTC+0 all year, so local == UTC.
    return datetime(year, month, d, hour, minute, tzinfo=timezone.utc)


# --------------------------------------------------------------------------
# Blurhash (port of the reference encoder) + thumbnail decoding via sips
# --------------------------------------------------------------------------
B83 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz#$%*+,-.:;=?@[]^_{|}~"


def _b83(value, length):
    return "".join(B83[(value // 83 ** (length - i)) % 83] for i in range(1, length + 1))


def _to_linear(v):
    v /= 255
    return v / 12.92 if v <= 0.04045 else ((v + 0.055) / 1.055) ** 2.4


def _to_srgb(v):
    v = max(0.0, min(1.0, v))
    if v <= 0.0031308:
        return int(v * 12.92 * 255 + 0.5)
    return int((1.055 * v ** (1 / 2.4) - 0.055) * 255 + 0.5)


def blurhash(pixels, w, h, cx=4, cy=3):
    lin = [[tuple(_to_linear(c) for c in px) for px in row] for row in pixels]
    factors = []
    for j in range(cy):
        for i in range(cx):
            norm = 1 if i == 0 and j == 0 else 2
            r = g = b = 0.0
            for y in range(h):
                cos_y = math.cos(math.pi * j * y / h)
                for x in range(w):
                    basis = norm * math.cos(math.pi * i * x / w) * cos_y
                    pr, pg, pb = lin[y][x]
                    r += basis * pr
                    g += basis * pg
                    b += basis * pb
            s = 1 / (w * h)
            factors.append((r * s, g * s, b * s))
    dc, ac = factors[0], factors[1:]
    out = _b83((cx - 1) + (cy - 1) * 9, 1)
    if ac:
        actual_max = max(abs(c) for f in ac for c in f)
        quant = max(0, min(82, int(math.floor(actual_max * 166 - 0.5))))
        max_val = (quant + 1) / 166
        out += _b83(quant, 1)
    else:
        max_val = 1
        out += _b83(0, 1)
    out += _b83((_to_srgb(dc[0]) << 16) + (_to_srgb(dc[1]) << 8) + _to_srgb(dc[2]), 4)
    for f in ac:
        q = [
            int(max(0, min(18, math.floor(math.copysign(abs(c / max_val) ** 0.5, c) * 9 + 9.5))))
            for c in f
        ]
        out += _b83(q[0] * 19 * 19 + q[1] * 19 + q[2], 2)
    return out


def _read_bmp(path):
    data = open(path, "rb").read()
    offset = struct.unpack_from("<I", data, 10)[0]
    w, h = struct.unpack_from("<ii", data, 18)
    bpp = struct.unpack_from("<H", data, 28)[0]
    bottom_up = h > 0
    h = abs(h)
    step = bpp // 8
    stride = (w * step + 3) & ~3
    rows = []
    for y in range(h):
        row_start = offset + y * stride
        rows.append(
            [(data[row_start + x * step + 2], data[row_start + x * step + 1], data[row_start + x * step])
             for x in range(w)]
        )
    return (rows[::-1] if bottom_up else rows), w, h


def hash_for(thumb_url, key):
    os.makedirs(CACHE, exist_ok=True)
    src = os.path.join(CACHE, key + ".img")
    bmp = os.path.join(CACHE, key + ".bmp")
    if not os.path.exists(bmp):
        req = urllib.request.Request(thumb_url, headers={"User-Agent": "petalsinajar-seed/1.0"})
        for attempt in range(4):
            try:
                with urllib.request.urlopen(req, timeout=30) as r:
                    body = r.read()
                break
            except (OSError, urllib.error.URLError):
                if attempt == 3:
                    raise
                time.sleep(2 ** attempt)
        with open(src, "wb") as f:
            f.write(body)
        subprocess.run(["sips", "-s", "format", "bmp", src, "--out", bmp],
                       check=True, capture_output=True)
    pixels, w, h = _read_bmp(bmp)
    return blurhash(pixels, w, h, 4, 3 if h <= w else 4)


# Ids picsum doesn't serve (gaps in https://picsum.photos/v2/list).
_PICSUM_MISSING = {86, 97, 105, 138, 148, 150}
PICSUM_POOL = [i for i in range(10, 200) if i not in _PICSUM_MISSING]
rng.shuffle(PICSUM_POOL)


def picsum(w, h):
    pid = PICSUM_POOL.pop()
    tw, th = (32, max(8, round(32 * h / w)))
    return {
        "url": f"https://picsum.photos/id/{pid}/{w}/{h}",
        "blurhash": hash_for(f"https://picsum.photos/id/{pid}/{tw}/{th}", f"picsum_{pid}_{tw}x{th}"),
        "width": w,
        "height": h,
    }


def pravatar(n):
    return {
        "url": f"https://i.pravatar.cc/300?img={n}",
        "blurhash": hash_for(f"https://i.pravatar.cc/32?img={n}", f"pravatar_{n}"),
        "width": 300,
        "height": 300,
    }


def logo(name, bg):
    q = urllib.parse.urlencode({"name": name, "background": bg, "color": "fff", "bold": "true"})
    return {
        "url": f"https://ui-avatars.com/api/?{q}&size=256",
        "blurhash": hash_for(f"https://ui-avatars.com/api/?{q}&size=32&format=png",
                             "logo_" + name.replace(" ", "_").replace("&", "and")),
        "width": 256,
        "height": 256,
    }


def media(m):
    return {"id": ulid(), **m}


# --------------------------------------------------------------------------
# Users
# --------------------------------------------------------------------------
USER_DEFS = [
    # key, name, handle, avatar img, bio, phone
    ("ama", "Ama Mensah", "amamensah", 47, "Planning my dream white wedding 💍 · Owner @royalcanopies", "+233240000001"),
    ("kwame", "Kwame Boateng", "kwameb", 12, "Sound guy by day, DJ by night 🎧 · @basslinegh", "+233240000002"),
    ("efua", "Efua Owusu", "efua.o", 45, "Brunch, birthdays and beautiful tablescapes ✨", "+233240000003"),
    ("kofi", "Kofi Asante", "kofiasante", 13, "Fintech · events · good jollof", "+233240000004"),
    ("akosua", "Akosua Darko", "akosuad", 44, "Newly married 🤍 Accra → everywhere", "+233240000005"),
    ("yaw", "Yaw Appiah", "yawappiah", 59, "Dad of two party animals 🎈", "+233240000006"),
    ("abena", "Abena Ofori", "abenaofori", 32, "Kumasi girl. Engaged! 💛", "+233240000007"),
    ("kojo", "Kojo Addo", "kojoaddo", 52, "Ama's other half 🤍 Architect.", "+233240000008"),
]
USERS = {}
for key, name, handle, img, bio, phone in USER_DEFS:
    USERS[key] = {
        "id": ulid(),
        "name": name,
        "handle": handle,
        "phone": phone,
        "avatar": pravatar(img),
        "bio": bio,
        "followers_count": rng.randint(120, 4200),
        "following_count": rng.randint(80, 900),
        "posts_count": 0,
        "created_at": iso(GENERATED_AT - timedelta(days=rng.randint(60, 500))),
    }

# --------------------------------------------------------------------------
# Categories
# --------------------------------------------------------------------------
CATEGORY_DEFS = [
    ("canopies", "Canopies & tents", "deck", ["wedding", "birthday", "corporate"]),
    ("chairs", "Chairs", "chair", ["wedding", "birthday", "corporate"]),
    ("tables", "Tables", "table_restaurant", ["wedding", "birthday", "corporate"]),
    ("decor", "Décor & florals", "local_florist", ["wedding", "birthday"]),
    ("linens", "Linens", "texture", ["wedding", "birthday", "corporate"]),
    ("sound", "Sound", "speaker", ["wedding", "birthday", "corporate"]),
    ("lighting", "Lighting", "light", ["wedding", "birthday", "corporate"]),
    ("cake", "Cake & dessert", "cake", ["wedding", "birthday"]),
    ("catering", "Catering equipment", "restaurant", ["wedding", "birthday", "corporate"]),
    ("balloons", "Balloons", "celebration", ["birthday", "wedding"]),
    ("kids", "Kids' party", "child_care", ["birthday"]),
    ("staging", "Staging & AV", "stadium", ["corporate"]),
]
CATEGORIES = {
    slug: {"id": ulid(), "slug": slug, "name": name, "icon": icon, "event_types": types, "position": i}
    for i, (slug, name, icon, types) in enumerate(CATEGORY_DEFS)
}

# --------------------------------------------------------------------------
# Vendors
# --------------------------------------------------------------------------
VENDOR_DEFS = [
    # key, name, handle, specialty, city, bg, bio, members, event types, delivery fee
    ("royal", "Royal Canopies & Chairs", "royalcanopies", "canopies_chairs", "Accra", "B5446E",
     "Canopies, chairs and tables for 20 to 2,000 guests. Set-up included.",
     [("ama", "owner")], ["wedding", "birthday", "corporate"], 15000),
    ("golden", "Golden Touch Décor", "goldentouchdecor", "decor", "Accra", "C08B2C",
     "Florals, backdrops and tablescapes with a Ghanaian twist.",
     [], ["wedding", "birthday"], 20000),
    ("bassline", "Bassline Sound & Lights", "basslinegh", "sound_lighting", "Accra", "2F5BEA",
     "PA, DJ gear, uplighting and LED dance floors. Engineers on site.",
     [("kwame", "owner")], ["wedding", "birthday", "corporate"], 25000),
    ("crumbs", "Sweet Crumbs Cake & Catering Gear", "sweetcrumbs", "cakes_catering", "Tema", "E4475B",
     "Cake stands, chafing dishes and dessert displays.",
     [], ["wedding", "birthday", "corporate"], 10000),
    ("pop", "Pop & Party Balloons", "popandparty", "balloons_kids", "Accra", "F28C28",
     "Balloon garlands, bouncy castles and kids' party fun.",
     [], ["birthday"], 12000),
    ("stagecraft", "Stagecraft Corporate Events", "stagecraftgh", "corporate_staging", "Accra", "1F8A70",
     "Stages, LED walls and AV for conferences and launches.",
     [], ["corporate"], 40000),
]
VENDORS = {}
for key, name, handle, spec, city, bg, bio, members, types, fee in VENDOR_DEFS:
    VENDORS[key] = {
        "id": ulid(),
        "name": name,
        "handle": handle,
        "specialty": spec,
        "bio": bio,
        "city": city,
        "logo": logo(name, bg),
        "cover": picsum(1600, 900),
        "rating": round(rng.uniform(4.3, 4.95), 2),
        "reviews_count": rng.randint(18, 240),
        "followers_count": rng.randint(800, 12000),
        "verified": key in ("royal", "bassline", "stagecraft", "golden"),
        "event_types": types,
        "members": [{"user_id": USERS[u]["id"], "role": role} for u, role in members],
        "response_time_minutes": rng.choice([15, 30, 45, 60, 120]),
        "delivery": {"offers_delivery": True, "offers_pickup": True, "base_fee_minor": fee, "currency": CURRENCY},
        "created_at": iso(GENERATED_AT - timedelta(days=rng.randint(200, 900))),
    }

# --------------------------------------------------------------------------
# Items (MongoDB inventory)
# --------------------------------------------------------------------------
ALL = ["wedding", "birthday", "corporate"]
W, B, C = ["wedding"], ["birthday"], ["corporate"]
# vendor, title, category, unit, event types, min qty, tiers [(min_qty, amount)], variants [(name, attrs, stock)]
ITEM_DEFS = [
    ("royal", "Classic white canopy 10×10 ft", "canopies", "per_day", ALL, 1, [(1, 45000), (5, 42000)],
     [("White", {"color": "white"}, 12), ("Ivory", {"color": "ivory"}, 6)]),
    ("royal", "Pagoda canopy with drapes", "canopies", "per_day", W + C, 1, [(1, 85000)],
     [("White & gold", {"color": "white/gold"}, 4), ("White & silver", {"color": "white/silver"}, 3)]),
    ("royal", "Chiavari chair", "chairs", "per_day", W + B, 20, [(20, 1200), (100, 1000), (300, 850)],
     [("Gold", {"color": "gold"}, 400), ("Silver", {"color": "silver"}, 300), ("Clear acrylic", {"color": "clear"}, 150)]),
    ("royal", "Plastic stackable chair", "chairs", "per_day", ALL, 50, [(50, 300), (200, 250)],
     [("White", {"color": "white"}, 800), ("Red", {"color": "red"}, 300)]),
    ("royal", "Banquet chair with cover", "chairs", "per_day", ALL, 20, [(20, 800), (100, 700)],
     [("White cover", {"color": "white"}, 500), ("Black cover", {"color": "black"}, 200)]),
    ("royal", "Round banquet table (10 seater)", "tables", "per_day", ALL, 2, [(2, 3500), (10, 3000)],
     [("6 ft", {"size": "6ft"}, 60)]),
    ("royal", "Rectangular trestle table", "tables", "per_day", ALL, 1, [(1, 2500)],
     [("6 ft", {"size": "6ft"}, 80), ("8 ft", {"size": "8ft"}, 40)]),
    ("royal", "Kids' chair & table set", "chairs", "per_day", B, 1, [(1, 2000)],
     [("Pastel", {"color": "pastel"}, 30), ("Primary colours", {"color": "primary"}, 25)]),

    ("golden", "Floral centrepiece – blush & ivory", "decor", "per_event", W, 1, [(1, 15000), (10, 13500)],
     [("Small", {"size": "small"}, 40), ("Large", {"size": "large"}, 20)]),
    ("golden", "Gold charger plates", "decor", "per_event", W + B, 50, [(50, 400), (200, 350)],
     [("Gold", {"color": "gold"}, 600), ("Silver", {"color": "silver"}, 400)]),
    ("golden", "Fairy-light backdrop 8×8 ft", "decor", "per_event", W + B, 1, [(1, 60000)],
     [("Warm white", {"color": "warm white"}, 3)]),
    ("golden", "Kente-accent table runner", "linens", "per_event", ALL, 10, [(10, 1500)],
     [("Gold & green", {"color": "gold/green"}, 120), ("Red & gold", {"color": "red/gold"}, 80)]),
    ("golden", "Satin tablecloth", "linens", "per_event", ALL, 10, [(10, 2000), (50, 1700)],
     [("White", {"color": "white"}, 200), ("Ivory", {"color": "ivory"}, 150), ("Champagne", {"color": "champagne"}, 100)]),
    ("golden", "Floral arch", "decor", "per_event", W, 1, [(1, 120000)],
     [("Roses", {"style": "roses"}, 2), ("Tropical", {"style": "tropical"}, 2)]),
    ("golden", "Lounge set (sofa + 2 armchairs)", "decor", "per_day", W + C, 1, [(1, 150000)],
     [("White leather", {"color": "white"}, 3), ("Emerald velvet", {"color": "emerald"}, 2)]),

    ("bassline", "PA system (2 tops + sub)", "sound", "per_day", ALL, 1, [(1, 90000)],
     [("Standard", {}, 4)]),
    ("bassline", "Wireless microphone pair", "sound", "per_day", ALL, 1, [(1, 15000)],
     [("Handheld", {"type": "handheld"}, 12), ("Lapel", {"type": "lapel"}, 8)]),
    ("bassline", "DJ booth with controller", "sound", "per_day", W + B, 1, [(1, 120000)],
     [("Standard", {}, 2)]),
    ("bassline", "Uplighting kit (8 lights)", "lighting", "per_day", ALL, 1, [(1, 40000)],
     [("RGB", {}, 6)]),
    ("bassline", "Moving head lights (pair)", "lighting", "per_day", ALL, 1, [(1, 70000)],
     [("Beam", {"type": "beam"}, 4), ("Spot", {"type": "spot"}, 3)]),
    ("bassline", "LED dance floor 16×16 ft", "lighting", "per_day", W + B, 1, [(1, 250000)],
     [("Standard", {}, 1)]),
    ("bassline", "Fog machine", "lighting", "per_day", W + B, 1, [(1, 20000)],
     [("Low fog", {"type": "low"}, 3), ("Haze", {"type": "haze"}, 3)]),

    ("crumbs", "Tiered cake stand", "cake", "per_event", W + B, 1, [(1, 5000)],
     [("Gold 3-tier", {"style": "gold"}, 15), ("Acrylic", {"style": "acrylic"}, 10), ("Rustic wood", {"style": "wood"}, 8)]),
    ("crumbs", "Chafing dish set", "catering", "per_event", ALL, 4, [(4, 6000), (12, 5200)],
     [("Full size", {"size": "full"}, 60), ("Half size", {"size": "half"}, 40)]),
    ("crumbs", "Dessert table display set", "catering", "per_event", W + B, 1, [(1, 30000)],
     [("Gold", {"color": "gold"}, 4), ("White", {"color": "white"}, 4)]),
    ("crumbs", "Drinks dispenser 10 L", "catering", "per_event", ALL, 2, [(2, 4000)],
     [("Glass", {}, 30)]),
    ("crumbs", "Cake knife & server set", "cake", "per_event", W + B, 1, [(1, 1500)],
     [("Gold", {"color": "gold"}, 20), ("Silver", {"color": "silver"}, 20)]),
    ("crumbs", "Popcorn machine", "catering", "per_day", B + C, 1, [(1, 25000)],
     [("Standard", {}, 3)]),

    ("pop", "Balloon garland (3 m)", "balloons", "per_event", B + W, 1, [(1, 35000)],
     [("Pastel", {"palette": "pastel"}, 10), ("Gold & white", {"palette": "gold/white"}, 8), ("Rainbow", {"palette": "rainbow"}, 8)]),
    ("pop", "Giant foil number balloon", "balloons", "per_event", B, 1, [(1, 3000)],
     [("Gold", {"color": "gold"}, 50), ("Silver", {"color": "silver"}, 40), ("Rose gold", {"color": "rose gold"}, 40)]),
    ("pop", "Bouncy castle", "kids", "per_day", B, 1, [(1, 80000)],
     [("Princess", {"theme": "princess"}, 2), ("Jungle", {"theme": "jungle"}, 2)]),
    ("pop", "Kids' ball pit", "kids", "per_day", B, 1, [(1, 45000)],
     [("Standard", {}, 3)]),
    ("pop", "Helium balloon bouquet", "balloons", "per_event", B + W, 1, [(1, 12000)],
     [("Mixed", {}, 25)]),
    ("pop", "Face painting (artist, 2 hours)", "kids", "per_event", B, 1, [(1, 50000)],
     [("2-hour session", {}, 4)]),

    ("stagecraft", "Modular stage 8×4 m", "staging", "per_day", C + W, 1, [(1, 300000)],
     [("Carpeted black", {"finish": "black carpet"}, 2)]),
    ("stagecraft", "LED screen wall 3×2 m", "staging", "per_day", C, 1, [(1, 450000)],
     [("Indoor P3", {"pitch": "P3"}, 2), ("Outdoor P4", {"pitch": "P4"}, 1)]),
    ("stagecraft", "Lectern with microphone", "staging", "per_day", C, 1, [(1, 25000)],
     [("Acrylic", {"finish": "acrylic"}, 4), ("Wood", {"finish": "wood"}, 3)]),
    ("stagecraft", "Pipe & drape backdrop", "staging", "per_day", C + W, 2, [(2, 30000), (6, 26000)],
     [("Black", {"color": "black"}, 10), ("White", {"color": "white"}, 10)]),
    ("stagecraft", "Projector & 120\" screen", "staging", "per_day", C, 1, [(1, 60000)],
     [("HD", {}, 5)]),
    ("stagecraft", "Step-and-repeat banner 3×2 m", "staging", "per_event", C, 1, [(1, 80000)],
     [("Printed with your logo", {}, 6)]),
]
ITEMS = []
for vkey, title, cat, unit, types, min_qty, tiers, variants in ITEM_DEFS:
    ITEMS.append({
        "id": object_id(),
        "vendor_id": VENDORS[vkey]["id"],
        "category_id": CATEGORIES[cat]["id"],
        "title": title,
        "description": f"{title} from {VENDORS[vkey]['name']}. Cleaned, checked and delivered on time.",
        "media": [media(picsum(1000, 1000)) for _ in range(rng.choice([2, 3]))],
        "event_types": types,
        "price_unit": unit,
        "currency": CURRENCY,
        "min_quantity": min_qty,
        "price_tiers": [{"min_quantity": q, "amount_minor": a} for q, a in tiers],
        "variants": [
            {"id": object_id(), "name": n, "attributes": attrs, "sku": f"{vkey[:3].upper()}-{len(ITEMS):02d}-{i}",
             "stock_quantity": stock}
            for i, (n, attrs, stock) in enumerate(variants)
        ],
        "status": "active",
        "rating": round(rng.uniform(4.2, 5.0), 1),
        "reviews_count": rng.randint(3, 90),
        "_vendor": vkey,
    })
assert len(ITEMS) == 40, len(ITEMS)


def item(i):
    return ITEMS[i]


def unit_price(it, qty):
    return max((t for t in it["price_tiers"] if qty >= t["min_quantity"]),
               key=lambda t: t["min_quantity"])["amount_minor"]


# --------------------------------------------------------------------------
# Packages
# --------------------------------------------------------------------------
PACKAGE_DEFS = [
    ("royal", "White wedding essentials (100 guests)", W, [(0, 0, 3), (2, 0, 100), (5, 0, 10)], 0.12),
    ("golden", "Golden glam reception décor", W, [(8, 1, 10), (9, 0, 100), (11, 0, 10), (10, 0, 1)], 0.10),
    ("bassline", "Party starter sound & light", W + B, [(15, 0, 1), (16, 0, 1), (18, 0, 1)], 0.15),
    ("pop", "Kids' birthday bash", B, [(30, 1, 1), (28, 0, 1), (29, 0, 2), (32, 0, 2)], 0.10),
    ("stagecraft", "Conference in a box", C, [(34, 0, 1), (36, 0, 1), (38, 0, 1), (37, 0, 4)], 0.12),
]
PACKAGES = []
for vkey, title, types, lines, discount in PACKAGE_DEFS:
    contents = []
    full = 0
    for idx, vidx, qty in lines:
        it = item(idx)
        assert it["_vendor"] == vkey
        full += unit_price(it, qty) * qty
        contents.append({"item_id": it["id"], "variant_id": it["variants"][vidx]["id"], "quantity": qty})
    PACKAGES.append({
        "id": ulid(),
        "vendor_id": VENDORS[vkey]["id"],
        "title": title,
        "description": f"Everything you need, bundled by {VENDORS[vkey]['name']}.",
        "cover": picsum(1600, 900),
        "event_types": types,
        "items": contents,
        "amount_minor": int(round(full * (1 - discount), -2)),
        "compare_at_minor": full,
        "currency": CURRENCY,
    })

# --------------------------------------------------------------------------
# Events
# --------------------------------------------------------------------------
EVENT_DEFS = [
    # key, type, title, start, hours, venue, city, guests, visibility, host, co-hosts, invited
    ("ama_wedding", "wedding", "Ama & Kojo's White Wedding", at(12, 12, 14), 8,
     "Aburi Botanical Gardens", "Aburi", 250, "guests", "ama", ["kojo"],
     ["efua", "kofi", "akosua", "yaw", "abena", "kwame"]),
    ("efua_30", "birthday", "Efua turns 30 🎉", at(10, 24, 19), 5,
     "Sandbox Beach Club, Labadi", "Accra", 80, "public", "efua", [],
     ["ama", "akosua", "abena", "kojo"]),
    ("fintech_summit", "corporate", "Fintech Ghana Summit 2026", at(11, 6, 9), 9,
     "Accra International Conference Centre", "Accra", 600, "public", "kofi", [],
     ["kwame", "kojo", "ama"]),
    ("nana_5th", "birthday", "Nana Yaw's 5th birthday", at(10, 12, 13), 4,
     "Legon Botanical Gardens", "Accra", 40, "guests", "yaw", [],
     ["ama", "efua", "akosua"]),
    ("abena_engagement", "wedding", "Abena & Kwesi's traditional engagement", at(11, 21, 10), 7,
     "Golden Tulip Kumasi City", "Kumasi", 150, "guests", "abena", [],
     ["ama", "efua", "akosua", "kojo"]),
    ("bassline_party", "corporate", "Bassline end-of-year staff party", at(12, 18, 18), 6,
     "Mövenpick Ambassador Hotel", "Accra", 120, "private", "kwame", [],
     ["kofi", "yaw"]),
    ("akosua_wedding", "wedding", "Akosua & Daniel's garden wedding", at(8, 15, 15), 8,
     "Peduase Valley Resort", "Aburi", 200, "public", "akosua", [],
     ["ama", "efua", "kofi", "abena", "kojo", "kwame"]),
    ("kwame_40", "birthday", "Kwame's 40th rooftop party", at(9, 20, 20), 5,
     "Sky Bar 25, Villaggio", "Accra", 90, "public", "kwame", [],
     ["ama", "kofi", "yaw", "efua"]),
    ("startup_mixer", "corporate", "Accra Startup Week mixer", at(9, 3, 17), 4,
     "Impact Hub Accra", "Accra", 150, "public", "kofi", [],
     ["kojo", "abena", "kwame"]),
    ("kofi_brunch", "birthday", "Kofi's birthday brunch", at(10, 11, 11), 4,
     "Kofi's garden, East Legon", "Accra", 30, "guests", "kofi", [],
     ["ama", "kwame", "efua"]),
]
EVENTS = {}
for key, etype, title, start, hours, venue, city, guests, vis, host, cohosts, invited in EVENT_DEFS:
    statuses = ["going", "going", "going", "maybe", "declined", "invited"]
    guest_list = [{"user_id": USERS[u]["id"], "status": rng.choice(statuses)} for u in invited]
    counts = {s: sum(1 for g in guest_list if g["status"] == s) for s in ("going", "maybe", "declined", "invited")}
    # Headline counts include guests who aren't seeded users.
    counts["going"] += int(guests * rng.uniform(0.3, 0.6))
    counts["maybe"] += int(guests * rng.uniform(0.05, 0.15))
    EVENTS[key] = {
        "id": ulid(start - timedelta(days=60)),
        "type": etype,
        "title": title,
        "description": f"Join us for {title}!",
        "starts_at": iso(start),
        "ends_at": iso(start + timedelta(hours=hours)),
        "venue": {"name": venue, "city": city, "address": f"{venue}, {city}, Ghana"},
        "guest_count": guests,
        "visibility": vis,
        "cover": picsum(1600, 900),
        "host_id": USERS[host]["id"],
        "co_host_ids": [USERS[u]["id"] for u in cohosts],
        "guests": guest_list,
        "rsvp_counts": counts,
        "created_at": iso(start - timedelta(days=60)),
    }

# --------------------------------------------------------------------------
# Posts (with shop-the-look tags)
# --------------------------------------------------------------------------
# author ("u"|"v", key), event key|None, days ago, caption, media specs:
# each media spec is a list of tags: ("i", item index) | ("v", vendor key) | ("u", user key)
POST_DEFS = [
    (("u", "akosua"), "akosua_wedding", 55, "Still not over our garden wedding 🤍 Canopies by @royalcanopies, florals by @goldentouchdecor #AccraWeddings #GardenWedding",
     [[("i", 1), ("i", 2)], [("i", 8), ("i", 9)], []]),
    (("u", "efua"), "akosua_wedding", 55, "The tablescape at @akosuad's wedding was everything ✨ #Tablescape",
     [[("i", 8), ("i", 12), ("i", 9)]]),
    (("v", "royal"), "akosua_wedding", 54, "200 gold chiavari chairs, two pagoda canopies and one very happy couple 🤍 #RoyalSetups",
     [[("i", 2), ("i", 1)], [("i", 5)]]),
    (("v", "golden"), "akosua_wedding", 53, "Blush & ivory centrepieces for @akosuad 🌸 Book yours for December! #WeddingDecor",
     [[("i", 8)], [("i", 13)]]),
    (("u", "kojo"), "akosua_wedding", 54, "When the DJ plays 'Kpanlogo' and the aunties take over the dance floor 😂 @basslinegh #GhanaWeddings",
     [[("i", 20), ("v", "bassline")]]),
    (("u", "ama"), "akosua_wedding", 52, "Taking notes for our own big day 📝 @kojoaddo we need this arch #Inspo",
     [[("i", 13), ("u", "kojo")]]),
    (("u", "kwame"), "kwame_40", 21, "40 and fabulous 🥂 Thank you all for coming! #KwameAt40",
     [[("u", "kofi"), ("i", 19)], [], [("i", 15)]]),
    (("v", "bassline"), "kwame_40", 20, "Our own boss turned 40, so we brought the moving heads out 💡 #BasslineLights",
     [[("i", 19), ("i", 18)], [("i", 17)]]),
    (("u", "yaw"), "kwame_40", 20, "Rooftop views + good music. Happy birthday @kwameb 🎉",
     [[("u", "kwame")]]),
    (("u", "efua"), "kwame_40", 21, "Cake moment 🎂 stand from @sweetcrumbs #BirthdayCake",
     [[("i", 22), ("i", 26)]]),
    (("u", "kofi"), "startup_mixer", 37, "Great energy at #AccraStartupWeek 🚀 thanks @stagecraftgh for the AV",
     [[("i", 35), ("i", 36)], [("i", 38)]]),
    (("v", "stagecraft"), "startup_mixer", 36, "Pipe & drape + LED wall for 150 founders. Next stop: #FintechGhana2026",
     [[("i", 37), ("i", 35)]]),
    (("u", "abena"), "startup_mixer", 37, "Networking but make it fashion 💼 #AccraStartupWeek",
     [[]]),
    (("v", "pop"), None, 9, "Pastel garland for a little one's first birthday 🎈 Swipe for the number balloons! #KidsParty",
     [[("i", 28)], [("i", 29)]]),
    (("v", "pop"), None, 15, "Princess castle is back in stock 👑 #BouncyCastle #AccraKids",
     [[("i", 30)]]),
    (("v", "crumbs"), None, 12, "Dessert table goals 🍰 Gold display set + 3-tier stand #DessertTable",
     [[("i", 24), ("i", 22)], [("i", 26)]]),
    (("v", "golden"), None, 6, "New in: emerald velvet lounge sets 💚 Perfect for VIP corners #LoungeSet",
     [[("i", 14)], []]),
    (("v", "royal"), None, 4, "Rain or shine ☔️ Our 10×10 canopies keep your guests dry. #RoyalSetups",
     [[("i", 0)], [("i", 3)]]),
    (("v", "bassline"), None, 3, "LED dance floor test run before December season 🕺 #DanceFloor",
     [[("i", 20)]]),
    (("v", "stagecraft"), "fintech_summit", 2, "Building the main stage for @kofiasante's #FintechGhana2026 👷🏾",
     [[("i", 34), ("u", "kofi")]]),
    (("u", "ama"), "ama_wedding", 8, "Venue visit at Aburi today 🌿 62 days to go! @kojoaddo #AmaAndKojo",
     [[("u", "kojo")], []]),
    (("u", "kojo"), "ama_wedding", 7, "Chair debate: gold or clear chiavari? Vote below 👇🏾 #AmaAndKojo",
     [[("i", 2)], [("i", 2)]]),
    (("u", "efua"), "efua_30", 5, "Planning my 30th by the beach 🌊 thinking pastel garlands from @popandparty #Efua30",
     [[("i", 28)]]),
    (("u", "abena"), "abena_engagement", 10, "Kente swatches for our engagement 💛 #KumasiEngagement",
     [[("i", 11)], []]),
    (("u", "yaw"), "nana_5th", 3, "Jungle bouncy castle booked for Nana's 5th 🦁 @popandparty",
     [[("i", 30), ("v", "pop")]]),
    (("u", "akosua"), None, 18, "Throwback to the first dance 🤍 lights by @basslinegh #FirstDance",
     [[("i", 18), ("i", 21)]]),
    (("u", "kwame"), None, 1, "Soundcheck Sunday 🎧 #BasslineGH",
     [[("i", 15), ("i", 16)]]),
    (("v", "crumbs"), None, 1, "Chafing dishes polished and ready for the weekend 🔥 #CateringGhana",
     [[("i", 23)]]),
    (("u", "kofi"), "kofi_brunch", 0, "Brunch set-up is happening ☀️ thanks @royalcanopies!",
     [[("i", 0), ("i", 4)]]),
    (("v", "royal"), "kofi_brunch", 0, "On our way to East Legon 🚚 Happy birthday @kofiasante!",
     [[("i", 4)]]),
]
assert len(POST_DEFS) == 30, len(POST_DEFS)


def author_ref(kind, key):
    return {"type": "user", "id": USERS[key]["id"]} if kind == "u" else {"type": "vendor", "id": VENDORS[key]["id"]}


POSTS = []
for (kind, akey), ekey, days_ago, caption, media_specs in POST_DEFS:
    created = GENERATED_AT - timedelta(days=days_ago, hours=rng.randint(0, 6), minutes=rng.randint(0, 59))
    items_media = []
    for tags in media_specs:
        m = media(picsum(1080, 1350))
        m["tags"] = []
        for tkind, tval in tags:
            target = (
                {"type": "item", "id": item(tval)["id"]} if tkind == "i"
                else {"type": "vendor", "id": VENDORS[tval]["id"]} if tkind == "v"
                else {"type": "user", "id": USERS[tval]["id"]}
            )
            m["tags"].append({"id": ulid(created), "x": round(rng.uniform(0.15, 0.85), 3),
                              "y": round(rng.uniform(0.2, 0.85), 3), "target": target})
        items_media.append(m)
    likes = rng.randint(12, 950)
    POSTS.append({
        "id": ulid(created),
        "author": author_ref(kind, akey),
        "event_id": EVENTS[ekey]["id"] if ekey else None,
        "caption": caption,
        "media": items_media,
        "like_count": likes,
        "comment_count": rng.randint(0, max(1, likes // 12)),
        "save_count": rng.randint(0, likes // 5),
        "viewer_has_liked": rng.random() < 0.2,
        "viewer_has_saved": rng.random() < 0.1,
        "created_at": iso(created),
    })
    if kind == "u":
        USERS[akey]["posts_count"] += 1
POSTS.sort(key=lambda p: p["created_at"], reverse=True)

# --------------------------------------------------------------------------
# Bookings
# --------------------------------------------------------------------------
LIFECYCLE = ["pending_vendor", "accepted", "confirmed", "out_for_delivery", "delivered", "returned", "completed"]
BOOKING_DEFS = [
    # renter, event, vendor, status, fulfilment, lines [(item idx, variant idx, qty)], created days before GENERATED_AT
    ("efua", "efua_30", "royal", "pending_vendor", "delivery", [(3, 0, 60), (6, 0, 6)], 0),
    ("yaw", "nana_5th", "royal", "confirmed", "delivery", [(7, 1, 6), (0, 0, 2)], 6),
    ("kofi", "kofi_brunch", "royal", "out_for_delivery", "delivery", [(0, 0, 1), (4, 0, 30)], 9),
    ("ama", "ama_wedding", "golden", "pending_vendor", "delivery", [(8, 1, 25), (9, 0, 250), (13, 0, 1)], 1),
    ("ama", "ama_wedding", "bassline", "accepted", "delivery", [(15, 0, 1), (17, 0, 1), (20, 0, 1)], 2),
    ("akosua", "akosua_wedding", "royal", "completed", "delivery", [(1, 0, 2), (2, 0, 200), (5, 0, 20)], 80),
    ("kofi", "fintech_summit", "bassline", "declined", "delivery", [(19, 0, 2)], 12),
    ("efua", "efua_30", "pop", "confirmed", "pickup", [(28, 0, 2), (29, 0, 2)], 4),
]
BOOKINGS = []
for renter, ekey, vkey, status, fulfilment, lines, created_days in BOOKING_DEFS:
    ev = EVENTS[ekey]
    start = datetime.strptime(ev["starts_at"], "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)
    created = GENERATED_AT - timedelta(days=created_days, hours=rng.randint(1, 8))
    out_lines = []
    subtotal = 0
    for idx, vidx, qty in lines:
        it = item(idx)
        assert it["_vendor"] == vkey
        price = unit_price(it, qty)
        subtotal += price * qty
        out_lines.append({"item_id": it["id"], "variant_id": it["variants"][vidx]["id"], "title": it["title"],
                          "variant_name": it["variants"][vidx]["name"], "quantity": qty,
                          "unit_amount_minor": price, "line_total_minor": price * qty})
    fee = VENDORS[vkey]["delivery"]["base_fee_minor"] if fulfilment == "delivery" else 0
    total = subtotal + fee
    if status == "declined":
        reached = ["pending_vendor", "declined"]
    else:
        reached = LIFECYCLE[: LIFECYCLE.index(status) + 1]
    step = (min(start, GENERATED_AT) - created) / max(1, len(reached))
    timeline = [{"status": s, "at": iso(created + step * i)} for i, s in enumerate(reached)]
    BOOKINGS.append({
        "id": ulid(created),
        "user_id": USERS[renter]["id"],
        "event_id": ev["id"],
        "vendor_id": VENDORS[vkey]["id"],
        "status": status,
        "fulfilment": fulfilment,
        "delivery_address": ev["venue"]["address"] if fulfilment == "delivery" else None,
        "starts_on": day(start),
        "ends_on": day(start + timedelta(days=1)),
        "lines": out_lines,
        "subtotal_minor": subtotal,
        "delivery_fee_minor": fee,
        "deposit_minor": int(round(total * 0.3, -2)),
        "total_minor": total,
        "currency": CURRENCY,
        "respond_by_at": iso(created + timedelta(hours=24)) if status == "pending_vendor" else None,
        "hold_expires_at": iso(GENERATED_AT + timedelta(days=2)) if status == "accepted" else None,
        "timeline": timeline,
        "created_at": iso(created),
    })


# --------------------------------------------------------------------------
# Write
# --------------------------------------------------------------------------
def strip_private(obj):
    if isinstance(obj, dict):
        return {k: strip_private(v) for k, v in obj.items() if not k.startswith("_")}
    if isinstance(obj, list):
        return [strip_private(v) for v in obj]
    return obj


def write(name, data):
    os.makedirs(OUT, exist_ok=True)
    with open(os.path.join(OUT, f"{name}.json"), "w", encoding="utf-8") as f:
        json.dump({"generated_at": iso(GENERATED_AT), "data": strip_private(data)}, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"  {name}.json: {len(data)}")


print("Writing assets/mock:")
write("users", list(USERS.values()))
write("vendors", list(VENDORS.values()))
write("categories", list(CATEGORIES.values()))
write("items", ITEMS)
write("packages", PACKAGES)
write("events", list(EVENTS.values()))
write("posts", POSTS)
write("bookings", BOOKINGS)
