import 'dart:math';

import 'package:fase_2_radio/screens/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import 'package:fase_2_radio/widgets/program_carousel.dart';
import 'package:fase_2_radio/widgets/station_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        //actionsPadding:EdgeInsetsGeometry.symmetric(vertical: 20) ,-mueve los tre puntitos
        elevation: 15,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize:20),
        title: const Text("Radiactiva x"),
        backgroundColor: Color.fromARGB(255, 84, 0, 253),
        shadowColor: const Color.fromARGB(255, 7, 83, 214),
        actions: [
          Icon(Icons.more_vert,color: Color(0xffffffff),),
        ],
        ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, //ajusta el tama;o vertical
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  image: DecorationImage(image: AssetImage("assets/images/header2.jpg"),
                  fit: BoxFit.cover //ajusta imagen a todo el header del drawer
                  )
                  
                ),
                child: Text("RadioActiva",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffffffff)
                ),),
              ),
              ListTile(                //splashColor: Color.fromARGB(255, 177, 118, 118),
                leading: const Icon(Icons.dark_mode),//Modo oscuro
                title: Text("Modo oscuro"),
              ),
              ListTile(
                leading: const Icon(Icons.update),
                title: Text("Vesion 1.0.0"),
              )
            ]
          ),
        ),
        //CARRUSEL
        body: const ProgramCarousel()
        );
    }
  }
bool _encendido = true;

Future<bool> _checkOnboarding () async{
  final prefers = await SharedPreferences.getInstance();//Para verificar que que ya paso onboarding
  return prefers.getBool('onboardingSeen') ?? false;

}