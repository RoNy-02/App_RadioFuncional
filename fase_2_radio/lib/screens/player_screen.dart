import 'package:fase_2_radio/services/audio_service.dart';
import 'package:flutter/material.dart';



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
    _audioService.initRadio("https://stream.freepi.io/8012/live"); // aqui s llama a la funcion
  }

  @override
  void dispose() {
    _audioService.dispose(); // se cierra el reproductor al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Radio Player")),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () => _audioService.play(),
        ),
      ),
    );
  }
  
}
