import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Future<void> playRadio(String url, String title) async {
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

      await _player.play();
    } catch (e) {
      print('Error playing radio: $e');
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
}
