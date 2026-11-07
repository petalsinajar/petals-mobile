import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';

import '../../helpers/pump_app.dart';

const _badge = Key('avatar-vendor-badge');

void main() {
  test('initials', () {
    expect(Avatar.initialsOf('Ama Mensah'), 'AM');
    expect(Avatar.initialsOf('kwameb'), 'K');
    expect(Avatar.initialsOf('Golden Touch Décor'), 'GT');
    expect(Avatar.initialsOf('  '), '?');
  });

  testWidgets('falls back to initials without an image', (tester) async {
    await tester.pumpApp(const Avatar(name: 'Efua Owusu'));
    expect(find.text('EO'), findsOneWidget);
    expect(find.byKey(_badge), findsNothing);
  });

  testWidgets('vendors get a storefront badge', (tester) async {
    await tester.pumpApp(
      const Avatar(name: 'Royal Canopies', isVendor: true, size: AvatarSize.lg),
    );
    expect(find.byKey(_badge), findsOneWidget);
    expect(find.bySemanticsLabel('Royal Canopies, business'), findsOneWidget);
  });

  testWidgets('sizes follow the scale', (tester) async {
    await tester.pumpApp(
      const Center(
        child: Avatar(name: 'Yaw', size: AvatarSize.xl),
      ),
    );
    expect(
      tester.getSize(find.byType(Avatar)),
      Size.square(AvatarSize.xl.dimension),
    );
  });
}
