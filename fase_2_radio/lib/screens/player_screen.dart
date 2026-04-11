import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';



class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState(); // 'createState' en minúscula
  
}

class _PlayerScreenState extends State<PlayerScreen> {
  late StreamSubscription<dynamic> _playingStateSubscription;

  @override
  void initState() {
    super.initState();
    final audioProvider = context.read<AudioProvider>();
    
    // Escuchar cambios en el estado de reproducción
    _playingStateSubscription = audioProvider.playerStateStream.listen((_) {
      if (mounted) {
        setState(() {
          // El estado se actualiza automáticamente a través de Consumer
        });
      }
    });
  }

  @override
  void dispose() {
    _playingStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Radio Player")),
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  audioProvider.currentStationName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 84, 0, 253),
                        Color.fromARGB(255, 203, 8, 8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(
                    Icons.music_note,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 40,
                      onPressed: () async {
                        await audioProvider.previousStation();
                      },
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () async {
                        if (audioProvider.isPlaying) {
                          await audioProvider.pause();
                        } else {
                          await audioProvider.play();
                        }
                      },
                      child: Icon(
                        audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      iconSize: 40,
                      onPressed: () async {
                        await audioProvider.nextStation();
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
}

