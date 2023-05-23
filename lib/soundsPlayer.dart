import 'package:audioplayers/audioplayers.dart';

// class Player to control de sounds effects of the app, it´s asynchronous
class Player {
  static play(String src) async {
    final player = AudioPlayer();
    await player.play(AssetSource(src));
  }
}