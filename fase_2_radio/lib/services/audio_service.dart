import 'package:fase_2_radio/models/station_model.dart';
import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

    Future<void> initRadio(String url) async {
    try {
      await _player.setUrl(url);
    } catch (e) {
      print("Error cargando radio: $e");
    }
  }

  final List<String> Stations = [
    "https://stream.freepi.io/8012/live",
    "https://stream.freepi.io/8010/stream",
  ];

  int currentIndex = 0;
  //reproducir
  Future<void> play() async{
    await _player.play();
  }
  //pausar
  Future<void> pause() async{
    await _player.pause();
  }
  //siguiente
  Future<void> next() async{
    currentIndex = (currentIndex +1 )% Stations.length;
    await _player.setUrl(Stations[currentIndex]);
    await _player.play();
  }
  //anterior
  void previous() async {
    currentIndex = (currentIndex - 1 + Stations.length) % Stations.length;
    await _player.setUrl(Stations[currentIndex]);
    await _player.play();
  }
  //detener
  Future<void> dispose() async{
    await _player.dispose();
  }

}