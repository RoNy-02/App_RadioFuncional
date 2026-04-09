import 'dart:math';

import 'package:fase_2_radio/screens/player_screen.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
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
          elevation: 20,
          child: Column(
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  image: DecorationImage(image: AssetImage("assets/images/header.jpg"))
                ),
                child: Text("Mi app"),
              ),
            ]
          ),
        ),
        body: ElevatedButton(onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=> PlayerScreen()),//boton para ir al reproductor-de prueba
          );
        }, child: Text("Radio")),
    );
    
  }
}