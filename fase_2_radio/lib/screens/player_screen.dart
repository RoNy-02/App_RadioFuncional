import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:fase_2_radio/services/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';



class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState(); // 'createState' en minúscula
  
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioService _audioService = AudioService();
  


  @override
  void initState() {
    super.initState();

    Future.microtask((){
        final audioProvider = context.read<AudioProvider>();
      });

      _audioService.initRadio('https://stream.freepi.io:8010/stream');
    
    _audioService.playerStateStream.listen((state){
      setState(() {
        isPlaying = state.playing;//para que se cmabie alternamente y sincronizada con play y pause
      });

    }); // aqui s llama a la funcion
  }

  

  @override
  void dispose() {
    _audioService.dispose(); // se cierra el reproductor al salir
    super.dispose();
  }


  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Radio Player")),
      body: Row(
        children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: (){ _audioService.previous();
          }, //=> _audioService.play(),
        ),
        IconButton(onPressed: () async{
          if(isPlaying){
            await _audioService.pause();
          }else{
            await _audioService.play();
          }
          setState(() {
            isPlaying = !isPlaying;
          });
        }, 
        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: (){_audioService.next();
            },
          )
        ]
      ),
    );
  }
  
}

