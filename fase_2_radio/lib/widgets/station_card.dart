import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fase_2_radio/models/station_model.dart';

class EstacionCard extends StatelessWidget {
  final StationModel station;
  const EstacionCard({super.key, required this.station});//station debe ser required por que es un atributo final

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider>();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: [
          // Imagen de fondo completa
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(station.image, fit: BoxFit.cover, width: double.infinity, height: double.infinity, errorBuilder: (_, __, ___) => Container(color: Colors.grey[300])),
          ),
          // Overlay semi-transparente
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black54])),
          ),
          // Contenido
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox.shrink(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(station.name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  const SizedBox(height: 6),
                  Text(station.slogan, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                  IconButton(
                    onPressed: () async {
                      if (audio.currentStation?.id != station.id) {
                        await audio.setStation(station);
                      }
                      audio.isPlaying ? await audio.pause() : await audio.play();
                    },
                    icon: Icon(audio.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 40),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}