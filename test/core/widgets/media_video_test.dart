import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/media/autoplay.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/core/widgets/media_video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../helpers/pump_app.dart';

const _ready = Media(
  id: 'v1',
  kind: MediaKind.video,
  status: MediaStatus.ready,
  width: 1080,
  height: 1920,
  urls: {
    'hls': 'https://stream.test/v1.m3u8',
    'poster': 'https://stream.test/v1.jpg',
  },
);

void main() {
  setUp(
    () => VisibilityDetectorController.instance.updateInterval = Duration.zero,
  );

  Future<List<Uri>> pump(
    WidgetTester tester,
    Media media, {
    bool autoplay = false,
    bool wifi = false,
  }) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final asked = <Uri>[];
    await tester.pumpApp(
      SizedBox(
        width: 200,
        child: MediaVideo(
          media: media,
          autoplay: autoplay,
          // Never touch the real player: just note it was asked for.
          controllerFactory: (uri) {
            asked.add(uri);
            return VideoPlayerController.networkUrl(uri);
          },
        ),
      ),
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        onWifiProvider.overrideWith((ref) => Stream.value(wifi)),
      ],
    );
    await tester.pump();
    return asked;
  }

  testWidgets('still processing: a placeholder that says so', (tester) async {
    await pump(
      tester,
      const Media(
        id: 'v2',
        kind: MediaKind.video,
        status: MediaStatus.processing,
      ),
    );
    expect(find.text('Processing video…'), findsOneWidget);
    expect(find.byTooltip('Play video'), findsNothing);
  });

  testWidgets('a failed video says it couldn’t be processed', (tester) async {
    await pump(
      tester,
      const Media(id: 'v3', kind: MediaKind.video, status: MediaStatus.failed),
    );
    expect(find.text('Video couldn’t be processed'), findsOneWidget);
  });

  testWidgets('ready: the poster first, with a play button', (tester) async {
    await pump(tester, _ready);
    final poster = tester.widget<MediaImage>(find.byType(MediaImage));
    expect(poster.media?.stillUrl, 'https://stream.test/v1.jpg');
    expect(find.byTooltip('Play video'), findsOneWidget);
  });

  testWidgets('in the feed on mobile data, it waits for a tap', (tester) async {
    final asked = await pump(tester, _ready, autoplay: true);
    await tester.pump(const Duration(milliseconds: 50));
    expect(asked, isEmpty, reason: 'no autoplay without Wi-Fi or permission');
  });

  testWidgets('in the feed on Wi-Fi, it starts once visible', (tester) async {
    final asked = await pump(tester, _ready, autoplay: true, wifi: true);
    await tester.pump(const Duration(milliseconds: 50));
    expect(asked, [Uri.parse('https://stream.test/v1.m3u8')]);
  });
}
