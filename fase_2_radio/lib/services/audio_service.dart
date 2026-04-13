import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import '../helpers/constants.dart';
import '../models/station_model.dart';

class RadioAudioHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  int _currentIndex = 0;

  RadioAudioHandler() {
    _player.playerStateStream.listen((state) {
      playbackState.add(
        PlaybackState(
          controls: [
            MediaControl.skipToPrevious,
            state.playing ? MediaControl.pause : MediaControl.play,
            MediaControl.skipToNext,
            MediaControl.stop,
          ],
          androidCompactActionIndices: const [0, 1, 2],
          playing: state.playing,
          processingState: _transform(state.processingState),
        ),
      );
    });
  }

  StationModel get _currentStation => stations[_currentIndex];

  void _updateMediaItem() {
    final station = _currentStation;

    Uri? artUri;
    if (station.imageUrl != null && station.imageUrl!.isNotEmpty) {
      artUri = Uri.parse(station.imageUrl!);
    } else if (station.image.startsWith('http')) {
      artUri = Uri.parse(station.image);
    } else {
      artUri = Uri.parse('asset:///${station.image}');//imagen de utills
    }
    mediaItem.add(
      MediaItem(
        id: station.Url,
        album: station.acronym,
        title: station.name,
        artist: station.slogan,
        artUri: artUri,
      ),
    );
  }
  Future<void> setUrl(String url, {int? index}) async {
    if (index != null) {
      _currentIndex = index;
    }

    _updateMediaItem();
    await _player.setUrl(url);
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'setUrl') {
      await setUrl(
        extras!['url'],
        index: extras['index'],
      );
    }
    return super.customAction(name, extras);
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future<void> skipToNext() async {
    _currentIndex = (_currentIndex + 1) % stations.length;
    final station = _currentStation;
    await setUrl(station.Url);
    await play();
  }

  @override
  Future<void> skipToPrevious() async {
    _currentIndex = (_currentIndex - 1 + stations.length) % stations.length;
    final station = _currentStation;
    await setUrl(station.Url);
    await play();
  }

  AudioProcessingState _transform(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }
}