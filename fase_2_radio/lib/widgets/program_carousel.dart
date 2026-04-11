import 'package:fase_2_radio/models/station_model.dart';
import 'package:fase_2_radio/widgets/station_card.dart';
import 'package:flutter/material.dart';

class ProgramCarousel extends StatelessWidget {
  const ProgramCarousel({super.key});  
  
  @override
  Widget build(BuildContext context) {
    final Stations =[
      Station(
        name:"RadioActiva",
        url:"https://stream.freepi.io:8010/stream" ,
        image: "assets/icons/RadioActivaStation.webp"
        ),
      Station(
        name:"Live Jazz Radio", 
        url:"https://stream.freepi.io/8012/live", 
        image:"assets/icons/LIVEJAZZ_RADIO_-_CDMX.webp")
    ];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: Stations.length,
      itemBuilder: (context, index) {
        return EstacionCard(station: Stations[index]);
      },
    );
  }
}