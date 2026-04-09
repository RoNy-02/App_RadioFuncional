import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

    Future<void> initRadio(String url) async {
    try {
      await _player.setUrl(url);
    } catch (e) {
      print("Error cargando radio: $e");
    }
  }

  Future<void> play() async{
    await _player.play();
  }
  Future<void> pause() async{
    await _player.pause();
  }
  Future<void> dispose() async{
    await _player.dispose();
  }

}