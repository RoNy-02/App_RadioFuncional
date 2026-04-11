import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fase_2_radio/screens/player_screen.dart';
import 'package:fase_2_radio/models/station_model.dart';

class EstacionCard extends StatelessWidget {
  final Station station;
  const EstacionCard({super.key, required this.station});//station debe ser required por que es un atributo final

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(station.image, height:150),
          const SizedBox(height: 10),
          Text(station.name),
          const SizedBox(height: 20),
          IconButton(onPressed: () async{
            if(audio.isPlaying){
              await audio.pause();
            }else{
              await audio.playRadio(station.url, station.name);
            }
          }, icon:
           Icon( audio.isPlaying ? Icons.pause : Icons.play_arrow)
           )
          // IconButton(
          //   onPressed: (){ 
          //   audio.playRadio(station.url, station.name
          // );},
          //  icon:
          //   Icon(audio.isPlaying ? Icons.pause : Icons.play_arrow))
        ],
      ),
    );
  }
}