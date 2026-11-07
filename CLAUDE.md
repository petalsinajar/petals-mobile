# Petalsinajar — Flutter client

Petalsinajar is a social app for events with built-in rentals. Hosts create events (weddings, birthdays, corporate), guests RSVP and post, and anyone can rent the chairs, tents, decor and sound they see in posts. Vendors use the same app in "vendor mode" to manage bookings, calendar and inventory.

The backend is Laravel (REST `/v1`, Sanctum bearer tokens, Reverb for real-time). Inventory lives in MongoDB (string ObjectIds); everything else is SQL (ULID string ids). Until the backend is ready, the app runs on a **mock data layer** with the same contracts.

## Non-negotiable architecture rules

1. **Feature-first structure.** Every feature is self-contained under `lib/features/<feature>/` with three layers:
   - `domain/` — immutable models (freezed) and abstract repository interfaces. No Flutter imports, no Dio.
   - `data/` — DTOs with json_serializable, a `remote` source (Dio), a `mock` source (seed JSON), and the repository implementation.
   - `presentation/` — screens, widgets, and Riverpod controllers/providers.
2. **Features never import another feature's `data/` or `presentation/` internals.** Cross-feature needs go through `domain/` interfaces or shared widgets in `lib/core/`.
3. **Repositories are swapped by one flag.** `AppConfig.useMocks` (from `--dart-define=USE_MOCKS=true`) decides whether providers return the mock or remote implementation. Screens never know which.
4. **State with Riverpod + code generation** (`@riverpod`). Async screens use `AsyncValue` with consistent loading (skeletons), error (retry) and empty states from `lib/core/widgets/`.
5. **Navigation only through go_router** with typed route constants in `lib/app/router/routes.dart`. Every shareable screen (event, post, item, vendor, profile) has a deep-linkable path.
6. **Models mirror the backend.** Same field names (camelCase in Dart, mapped from the API's JSON keys), ids as `String`, money as `int amountMinor` + `String currency` — never doubles. Format money only in the UI via `core/utils/money.dart`.
7. **One account, many roles.** The signed-in user can belong to vendors. `activeActorProvider` holds who the user is acting as (themself or a vendor). Vendor mode swaps the bottom navigation shell.
8. **Design system first.** Colors, typography, radii, spacing and motion durations live in `lib/app/theme/`. No hard-coded colors or magic numbers in feature code.
9. **Every new screen ships with** a loading skeleton, an empty state, an error state with retry, and pull-to-refresh where it lists data.
10. **Tests:** unit tests for repositories and controllers (mocktail), widget tests for key components. Run `dart run build_runner build -d`, `flutter analyze` and `flutter test` before saying a task is done; fix all warnings.

## Folder layout

```
lib/
  main.dart                     # reads dart-defines, runs bootstrap
  bootstrap.dart                # ProviderScope, error handling, init
  app/
    app.dart                    # MaterialApp.router
    config/app_config.dart      # baseUrl, useMocks, flavor
    router/                     # go_router, routes.dart, shells (user + vendor)
    theme/                      # tokens, ThemeData light/dark, motion
  core/
    network/                    # Dio client, interceptors (auth, retry, logging), ApiException, Paginated<T>
    storage/                    # secure token storage, preferences
    mock/                       # MockDelay, seed JSON loader
    widgets/                    # AppButton, Avatar, Skeleton, EmptyState, ErrorState, MediaImage (blurhash), etc.
    utils/                      # money, dates, timeago, validators, haptics
  features/
    auth/          # phone + OTP, session, me
    profile/       # user & vendor profiles, follow, edit profile
    feed/          # following + discover feeds, stories rail
    posts/         # post card, detail, create post, likes, comments, shop tags
    events/        # create event, event page, guests, RSVP, event feed
    catalog/       # categories, item list/search, item detail, availability, packages
    cart/          # multi-vendor cart per event, checkout (mock payment)
    bookings/      # my bookings, booking detail & timeline
    vendor/        # vendor mode: today, requests, calendar, inventory, blocks
    messaging/     # conversations, chat
    notifications/ # inbox
    boards/        # saved ideas boards
assets/
  mock/            # seed JSON: users, vendors, items, events, posts, bookings...
  animations/      # lottie files
```

## API contract (for remote sources)

- Base URL from `API_BASE_URL`, set per environment in `.env.dev` / `.env.prod` (gitignored; template `.env.example`) and passed with `--dart-define-from-file=.env.<env>`. All paths under `/v1`.
- Auth: `Authorization: Bearer <token>`; refresh on 401 once via `POST /v1/auth/refresh`, then sign out.
- Lists use cursor pagination: `{ "data": [...], "next_cursor": "..." | null }` → `Paginated<T>`.
- Errors: `{ "message": "...", "errors": { "field": ["..."] } }` → `ApiException` with field errors.
- Vendor-scoped calls include the vendor id in the path: `/v1/vendors/{vendorId}/...`.
- Booking actions are verbs: `POST /v1/bookings/{id}/accept|decline|cancel|dispatch|deliver|return`.

## The social feel (apply everywhere)

- Motion is part of the brand: use `flutter_animate` for entrance staggers on lists, `Hero` transitions from cards to detail, spring-like curves from `theme/motion.dart`.
- Double-tap to like with a heart burst + light haptic; like counts animate.
- Images load with blurhash placeholders and fade in; feeds never show blank boxes.
- Celebrate moments: confetti on booking confirmed and event created, playful empty states.
- Generous rounded cards, bold event-type colors (wedding, birthday, corporate each get an accent), avatars everywhere.
- Shop-the-look: tapping a post photo reveals tag pins; tapping a pin opens a bottom sheet with the item card and a "Rent this" button.

## Packages (use latest stable via `flutter pub add`; do not add others without saying why)

State & codegen: flutter_riverpod, riverpod_annotation, riverpod_generator, freezed, freezed_annotation, json_annotation, json_serializable, build_runner, custom_lint, riverpod_lint
Navigation & links: go_router, app_links, share_plus
Network & storage: dio, flutter_secure_storage, shared_preferences, connectivity_plus
Media: cached_network_image, flutter_blurhash, image_picker, video_player, photo_view
UI & motion: flutter_animate, lottie, confetti, skeletonizer, smooth_page_indicator, table_calendar, pinput, flutter_svg, google_fonts
Utils: intl, timeago, collection, uuid, logger
Testing & lints: mocktail, very_good_analysis

Later, not in the prototype: firebase_messaging (push), pusher-protocol client for Reverb (chat), google_maps_flutter, payment provider SDK.

## Working style

- Work in small, reviewable steps; finish one phase, summarize what changed, then stop for review.
- Prefer composition over inheritance; keep widgets small (split files over ~200 lines).
- Never commit secrets; config only through dart-defines (`.env.*` files are compiled into the binary, so they hold URLs and flags, never secrets).
