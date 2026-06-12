import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import '../../models/station_model.dart';
import '../constants.dart';

class AudioProvider with ChangeNotifier {
  AudioHandler? _audioHandler;
  

  StationModel? _currentStation;
  bool _isPlaying = false;
  bool _isLoading = false;

  StationModel? get currentStation => _currentStation;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  
  

  void setHandler(AudioHandler handler) {
    _audioHandler = handler;
    

    _audioHandler!.playbackState.listen((state) {
      _isPlaying = state.playing;
      _isLoading =
          state.processingState == AudioProcessingState.loading ||
          state.processingState == AudioProcessingState.buffering;
      notifyListeners();
      
    });

    _audioHandler!.mediaItem.listen((item) {
      if (item == null) return;
      final idx = stations.indexWhere((s) => s.Url == item.id);
      if (idx != -1) {
        _currentStation = stations[idx];
        notifyListeners();
        
      }
    });
  }
//estacion

    
  Future<void> setStation(StationModel station) async {
    if (_audioHandler == null) return;

    _currentStation = station;
    _isLoading = true;
    notifyListeners();

    int index = stations.indexWhere((s) => s.id == station.id);

    await _audioHandler!.customAction('setUrl', {
      'url': station.Url,
      'index': index,
    });

    _isLoading = false;
    notifyListeners();
  }

  Future<void> play() async {
    if (_audioHandler == null) return;
    await _audioHandler!.play();
  }

  Future<void> pause() async {
    if (_audioHandler == null) return;
    await _audioHandler!.pause();
  }

  Future<void> stop() async {
    if (_audioHandler == null) return;
    await _audioHandler!.stop();
  }

  Future<void> next() async {
    if (_audioHandler == null) return;
    await _audioHandler!.skipToNext();
  }

  Future<void> previous() async {
    if (_audioHandler == null) return;
    await _audioHandler!.skipToPrevious();
  }
  bool _isMiniPlayerVisible = true;
bool get isMiniPlayerVisible => _isMiniPlayerVisible;

void showMiniPlayer() {
  _isMiniPlayerVisible = true;
  notifyListeners();
}

void hideMiniPlayer() {
  _isMiniPlayerVisible = false;
  notifyListeners();
}
}