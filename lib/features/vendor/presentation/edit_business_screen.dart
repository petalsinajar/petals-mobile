import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/business_photo.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';

/// "GH₵150.50" typed as `150.50` → 15050 pesewas; null if not a number.
int? parseCedis(String text) {
  final value = double.tryParse(text.trim().replaceAll(',', ''));
  if (value == null || value < 0) return null;
  return (value * 100).round();
}

String _cedis(int minor) =>
    minor % 100 == 0 ? '${minor ~/ 100}' : (minor / 100).toStringAsFixed(2);

const _eventTypes = {
  'wedding': 'Weddings',
  'birthday': 'Birthdays',
  'corporate': 'Corporate',
  'other': 'Other',
};

/// Edit the storefront: photos, about, contact and delivery. Policies and
/// payouts stay on the web dashboard (owners only).
class EditBusinessScreen extends ConsumerWidget {
  const EditBusinessScreen({this.pickPhoto = pickBusinessPhoto, super.key});

  final BusinessPhotoPicker pickPhoto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actor = ref.watch(activeActorProvider);
    if (actor is! VendorActor) return const Scaffold();
    final provider = businessProvider(actor.vendorId);
    final value = ref.watch(provider);
    final business = value.value;
    if (business == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit business')),
        body: value.hasError
            ? ErrorState(
                error: value.error!,
                onRetry: () => ref.invalidate(provider),
              )
            : const Center(child: CircularProgressIndicator()),
      );
    }
    return _Form(business: business, pickPhoto: pickPhoto);
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.business, required this.pickPhoto});

  /// As it was when the form opened; edits are measured against it.
  final BusinessProfile business;
  final BusinessPhotoPicker pickPhoto;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  late final BusinessProfile _b = widget.business;
  late final _name = TextEditingController(text: _b.name);
  late final _bio = TextEditingController(text: _b.bio ?? '');
  late final _city = TextEditingController(text: _b.city ?? '');
  late final _phone = TextEditingController(text: _b.phone ?? '');
  late final _whatsapp = TextEditingController(text: _b.whatsapp ?? '');
  late final _email = TextEditingController(text: _b.email ?? '');
  late final _baseFee = TextEditingController(
    text: _cedis(_b.delivery.baseFeeMinor),
  );
  late final _setupFee = TextEditingController(
    text: _cedis(_b.delivery.setupFeeMinor),
  );
  late Set<String> _categories = {..._b.categories};
  late Set<String> _eventTypesSel = {..._b.eventTypes};
  late bool _delivers = _b.delivery.offered;
  late bool _setup = _b.delivery.setupOffered;
  late double _radius = (_b.serviceRadiusKm ?? 40).toDouble();
  String? _logoPath;
  String? _coverPath;
  var _saving = false;
  final _errors = <String, String>{};

  @override
  void dispose() {
    for (final c in [
      _name,
      _bio,
      _city,
      _phone,
      _whatsapp,
      _email,
      _baseFee,
      _setupFee,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Only what differs from the saved profile, in the API's field names.
  Map<String, Object?> get _changes {
    String? text(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();
    const sets = SetEquality<String>();
    final contact = {
      'phone': text(_phone),
      'whatsapp': text(_whatsapp),
      'email': text(_email),
    };
    final delivery = BusinessDelivery(
      offered: _delivers,
      baseFeeMinor: parseCedis(_baseFee.text) ?? _b.delivery.baseFeeMinor,
      setupOffered: _setup,
      setupFeeMinor: parseCedis(_setupFee.text) ?? _b.delivery.setupFeeMinor,
      perKmMinor: _b.delivery.perKmMinor,
    );
    return {
      if (_name.text.trim() != _b.name) 'name': _name.text.trim(),
      if (text(_bio) != _b.bio) 'bio': text(_bio),
      if (text(_city) != _b.city) 'city': text(_city),
      if (!sets.equals(_categories, _b.categories.toSet()))
        'categories': _categories.toList(),
      if (!sets.equals(_eventTypesSel, _b.eventTypes.toSet()))
        'event_types': _eventTypesSel.toList(),
      if (contact['phone'] != _b.phone ||
          contact['whatsapp'] != _b.whatsapp ||
          contact['email'] != _b.email)
        'contact': {
          for (final MapEntry(:key, :value) in contact.entries) key: ?value,
        },
      if (delivery != _b.delivery)
        'delivery': {
          'offered': delivery.offered,
          'base_fee_minor': delivery.baseFeeMinor,
          'setup_offered': delivery.setupOffered,
          'setup_fee_minor': delivery.setupFeeMinor,
          // The whole object is replaced, so send what the app doesn't edit.
          'per_km_minor': delivery.perKmMinor,
        },
      if (_radius.round() != _b.serviceRadiusKm)
        'service_radius_km': _radius.round(),
    };
  }

  Future<void> _pick({required bool logo}) async {
    final path = await widget.pickPhoto(logo: logo);
    if (path == null || !mounted) return;
    setState(() => logo ? _logoPath = path : _coverPath = path);
  }

  Future<void> _save() async {
    final email = _email.text.trim();
    final errors = <String, String>{
      if (_name.text.trim().isEmpty) 'name': 'Enter the business name.',
      if (email.isNotEmpty && !RegExp(r'^\S+@\S+\.\S+$').hasMatch(email))
        'contact.email': 'That email doesn’t look right.',
      if (_delivers && parseCedis(_baseFee.text) == null)
        'delivery.base_fee_minor': 'Enter a fee, e.g. 150 (or 0).',
      if (_setup && parseCedis(_setupFee.text) == null)
        'delivery.setup_fee_minor': 'Enter a fee, e.g. 100 (or 0).',
    };
    setState(() {
      _errors
        ..clear()
        ..addAll(errors);
    });
    if (errors.isNotEmpty) return;

    final changes = _changes;
    if (changes.isEmpty && _logoPath == null && _coverPath == null) {
      unawaited(Navigator.of(context).maybePop());
      return;
    }

    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(businessProvider(_b.id).notifier)
          .save(changes, logoPath: _logoPath, coverPath: _coverPath);
      unawaited(Haptics.success());
      if (!mounted) return;
      // Reset first: if there's nowhere to go back to, the form stays usable.
      setState(() => _saving = false);
      unawaited(Navigator.of(context).maybePop());
      messenger.showSnackBar(
        const SnackBar(content: Text('Business profile saved')),
      );
    } on MediaUploadException catch (e) {
      unawaited(Haptics.warning());
      if (!mounted) return;
      setState(() => _saving = false);
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } on ApiException catch (e) {
      unawaited(Haptics.warning());
      if (!mounted) return;
      setState(() {
        _saving = false;
        _errors.addAll({
          for (final MapEntry(:key, :value) in e.fieldErrors.entries)
            key: value.first,
        });
      });
      if (e.fieldErrors.isEmpty) {
        messenger.showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final categories = ref.watch(businessCategoriesProvider).value ?? const [];

    InputDecoration field(String label, String key, {String? hint}) =>
        InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: _errors[key],
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit business'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: AbsorbPointer(
        absorbing: _saving,
        child: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
          children: [
            _Photos(
              business: _b,
              logoPath: _logoPath,
              coverPath: _coverPath,
              onLogo: () => _pick(logo: true),
              onCover: () => _pick(logo: false),
            ),
            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    controller: _name,
                    maxLength: 120,
                    textCapitalization: TextCapitalization.words,
                    decoration: field('Business name', 'name'),
                  ),
                  TextField(
                    controller: _bio,
                    maxLength: 1000,
                    minLines: 2,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: field(
                      'About',
                      'bio',
                      hint: 'What you rent, your style, areas you cover',
                    ),
                  ),
                  TextField(
                    controller: _city,
                    maxLength: 80,
                    textCapitalization: TextCapitalization.words,
                    decoration: field('City', 'city'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('What you rent out', style: text.titleSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      for (final c in categories)
                        FilterChip(
                          label: Text(c.name),
                          selected: _categories.contains(c.id),
                          onSelected: (on) => setState(
                            () => _categories = on
                                ? {..._categories, c.id}
                                : ({..._categories}..remove(c.id)),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Events you serve', style: text.titleSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      for (final MapEntry(:key, :value) in _eventTypes.entries)
                        FilterChip(
                          label: Text(value),
                          selected: _eventTypesSel.contains(key),
                          onSelected: (on) => setState(
                            () => _eventTypesSel = on
                                ? {..._eventTypesSel, key}
                                : ({..._eventTypesSel}..remove(key)),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Contact', style: text.titleSmall),
                  TextField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: field('Phone', 'contact.phone'),
                  ),
                  TextField(
                    controller: _whatsapp,
                    keyboardType: TextInputType.phone,
                    decoration: field('WhatsApp', 'contact.whatsapp'),
                  ),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: field('Email', 'contact.email'),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Delivery', style: text.titleSmall),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('We deliver'),
                    subtitle: const Text('Off means customers pick up'),
                    value: _delivers,
                    onChanged: (v) => setState(() => _delivers = v),
                  ),
                  if (_delivers)
                    TextField(
                      controller: _baseFee,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      decoration: field(
                        'Delivery fee (GH₵)',
                        'delivery.base_fee_minor',
                      ),
                    ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('We set up on site'),
                    value: _setup,
                    onChanged: (v) => setState(() => _setup = v),
                  ),
                  if (_setup)
                    TextField(
                      controller: _setupFee,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      decoration: field(
                        'Setup fee (GH₵)',
                        'delivery.setup_fee_minor',
                      ),
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Serve events within ${_radius.round()} km',
                    style: text.titleSmall,
                  ),
                  Slider(
                    value: _radius.clamp(5, 200),
                    min: 5,
                    max: 200,
                    divisions: 39,
                    label: '${_radius.round()} km',
                    onChanged: (v) => setState(() => _radius = v),
                  ),
                  Text(
                    'Hosts further away won’t see you on Discover.',
                    style: text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    label: 'Save',
                    expand: true,
                    isLoading: _saving,
                    onPressed: _save,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Deposit, cancellation and payout settings are on the '
                    'web dashboard (owners only).',
                    textAlign: TextAlign.center,
                    style: text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Cover with the logo over it; tap either to change it.
class _Photos extends StatelessWidget {
  const _Photos({
    required this.business,
    required this.logoPath,
    required this.coverPath,
    required this.onLogo,
    required this.onCover,
  });

  static const _coverHeight = 150.0;

  final BusinessProfile business;
  final String? logoPath;
  final String? coverPath;
  final VoidCallback onLogo;
  final VoidCallback onCover;

  @override
  Widget build(BuildContext context) {
    final logo = AvatarSize.xl.dimension;
    final cover = switch ((coverPath, business.coverUrl)) {
      (final String path, _) => Image.file(File(path), fit: BoxFit.cover),
      (null, final String url) => MediaImage(url: url),
      _ => ColoredBox(color: context.palette.vendor.container),
    };
    return SizedBox(
      height: _coverHeight + logo / 2,
      child: Stack(
        children: [
          SizedBox(
            height: _coverHeight,
            width: double.infinity,
            child: Semantics(
              button: true,
              label: 'Change cover photo',
              excludeSemantics: true,
              child: InkWell(
                onTap: onCover,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    cover,
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Chip(
                          avatar: const Icon(Icons.photo_rounded, size: 16),
                          label: Text(
                            business.coverUrl == null && coverPath == null
                                ? 'Add cover'
                                : 'Change cover',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.screen,
            bottom: 0,
            child: Semantics(
              button: true,
              label: 'Change logo',
              excludeSemantics: true,
              child: GestureDetector(
                onTap: onLogo,
                child: Stack(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colors.surface,
                          width: 3,
                        ),
                      ),
                      child: logoPath == null
                          ? Avatar(
                              name: business.name,
                              imageUrl: business.logoUrl,
                              size: AvatarSize.xl,
                            )
                          : ClipOval(
                              child: Image.file(
                                File(logoPath!),
                                width: logo,
                                height: logo,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: context.colors.primary,
                        child: Icon(
                          Icons.photo_camera_rounded,
                          size: 16,
                          color: context.colors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
