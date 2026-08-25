import 'package:video_player/video_player.dart';

class SoundService {
  static Future<void> playSound() async {
    final VideoPlayerController controller = VideoPlayerController.asset(
      "assets/sound_effect/zoom_button.wav",
    );
    await controller.initialize();
    await controller.play();
  }
}
