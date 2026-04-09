import 'dart:async';

import 'package:fase_2_radio/screens/home_screen.dart';
import 'package:fase_2_radio/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
//para las notificaciones-lanzamiento
class _SplashScreenState extends State<SplashScreen> {

  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:5),
    ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen(),))
    );
  }
  Future<void> init() async{
    initializeTimeZones();

    setLocalLocation(getLocation('America/Mexico_city')
    );
    const androidSettings =
          AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings
    );
    await notificationsPlugin.initialize(settings: initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/imagen1.jpg"),//imagen del splash
            fit: BoxFit.cover, //para que se amplie la imagen
            opacity:0.4
          )
        ),
      child: Column(
          mainAxisAlignment:MainAxisAlignment.center,//centrar todo
        children: [
          Icon(Icons.music_note_outlined,size: 300,color: Colors.white,
          ),
            Text("RadioDay",
              style: TextStyle(color: Colors.white,fontSize:48,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
            )
          ]
        ),
      ),
    );
  }
}