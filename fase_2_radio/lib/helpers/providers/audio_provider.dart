import 'package:fase_2_radio/helpers/utills.dart';
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
  bool _isMiniPlayerVisible = false;
  bool get isMiniPlayerVisible => _isMiniPlayerVisible;
  
  // Getter público para acceder al stream
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  
  // Getters para compatibilidad
  StationModel? get currentStation => _currentStationIndex < _stations.length ? _stations[_currentStationIndex] : null;
  String get currentMetadataTitle => _currentStationName;
  bool get isLoading => _player.processingState == ProcessingState.loading || _player.processingState == ProcessingState.buffering;
  

  // Lista de estaciones disponibles
  final List<StationModel> _stations = [
    StationModel(
      id: "1",
      name: "RadioActiva",
      acronym: "RA",
      Url: "https://stream.freepi.io:8010/stream",
      slogan: "La mejor radio",
      image: "assets/icons/RadioActivaStation.webp",
    ),
    StationModel(
      id: "2",
      name: "Live Jazz Radio",
      acronym: "LJR",
      Url: "https://stream.freepi.io/8012/live",
      slogan: "Jazz en vivo",
      image: "assets/icons/LIVEJAZZ_RADIO_-_CDMX.webp",
    )
    
  ];

  AudioProvider() {
    _initializeControls();
  }

  void _initializeControls() {
    _player.playbackEventStream.listen((event) {
      notifyListeners();
    });
  }


  Future<void> playRadio(String url, String title) async {
    try {
      final station = currentStation;
      
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: station?.id ?? url,
            title: title,
            artist: station?.slogan,
            artUri: Uri.parse("asset:${station?.image ?? 'assets/icons/jazz_radio'}"),
            displayDescription: station?.name,
            displaySubtitle: station?.slogan,
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
      final station = currentStation;
      
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: station?.id ?? url,
            title: title,
            artist: station?.slogan ?? "Estación de Radio",
            artUri: Uri.parse("asset:${station?.image ?? 'assets/icons/navbar.png'}"),
            displayDescription: station?.name,
            displaySubtitle: station?.slogan,
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
    StationModel station = _stations[_currentStationIndex];
    await playRadio(station.Url, station.name);
  }
  
  // Ir a la estación anterior
  Future<void> previousStation() async {
    _currentStationIndex = (_currentStationIndex - 1 + _stations.length) % _stations.length;
    StationModel station = _stations[_currentStationIndex];
    await playRadio(station.Url, station.name);
  }
  
  // Alias para compatibilidad con player_screen
  Future<void> playNextStation() => nextStation();
  Future<void> playPreviousStation() => previousStation();
  
  // Mostrar/ocultar mini player
  void showMiniPlayer() {
    _isMiniPlayerVisible = true;
    notifyListeners(
      
    );
  }
  
  void hideMiniPlayer() {
    _isMiniPlayerVisible = false;
    notifyListeners();
  }

}
