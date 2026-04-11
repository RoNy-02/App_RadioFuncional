import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:fase_2_radio/models/station_model.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  
  int _currentStationIndex = 0;
  String _currentStationName = "RadioActiva";
  String get currentStationName => _currentStationName;
  
  // Getter público para acceder al stream
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  // Lista de estaciones disponibles
  final List<Station> _stations = [
    Station(
      name: "RadioActiva",
      url: "https://stream.freepi.io:8010/stream",
      image: "assets/icons/RadioActivaStation.webp",
    ),
    Station(
      name: "Live Jazz Radio",
      url: "https://stream.freepi.io/8012/live",
      image: "assets/icons/LIVEJAZZ_RADIO_-_CDMX.webp",
    )
  ];

  Future<void> playRadio(String url, String title) async {
    try {//try para que no se reprodusca la musica al deslizar
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: url,
            title: title,
            artist: "Radio",
            artUri: Uri.parse("https://via.placeholder.com/150"),
          ),
        ),
      );

      _player.playerStateStream.listen((state) {
        _isPlaying = state.playing;
        notifyListeners();
      });
      
      _currentStationName = title;
      notifyListeners();

      await _player.play();
    } catch (e) {
      print('Error playing radio: $e');
    }
  }

  // Cargar estación sin reproducir
  Future<void> setRadio(String url, String title) async {
    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: url,
            title: title,
            artist: "Radio",
            artUri: Uri.parse("https://via.placeholder.com/150"),
          ),
        ),
      );

      _player.playerStateStream.listen((state) {
        _isPlaying = state.playing;
        notifyListeners();
      });
      
      _currentStationName = title;
      notifyListeners();
    } catch (e) {
      print('Error setting radio: $e');
    }
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }
  
  // Ir a la siguiente estación
  Future<void> nextStation() async {
    _currentStationIndex = (_currentStationIndex + 1) % _stations.length;
    Station station = _stations[_currentStationIndex];
    await playRadio(station.url, station.name);
  }
  
  // Ir a la estación anterior
  Future<void> previousStation() async {
    _currentStationIndex = (_currentStationIndex - 1 + _stations.length) % _stations.length;
    Station station = _stations[_currentStationIndex];
    await playRadio(station.url, station.name);
  }
}
