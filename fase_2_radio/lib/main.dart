import 'package:fase_2_radio/screens/splash_screen.dart';
import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //problemas de dependencias para iniciar
  //uso de try y version reciente ^0.0.1-beta.15 para solucionar
  
  try {
    //configuracion de background
    await JustAudioBackground.init(
      androidNotificationChannelId: "com.example.radio.chanel.audio",
      androidNotificationChannelName: "Audio Playback",
      androidNotificationOngoing: true,
    );
  } catch (e) {
    print('Error initializing JustAudioBackground: $e');
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AudioProvider(),
      child: MaterialApp(
        title: 'App de Radio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 203, 8, 8)
        ),
        home: SplashScreen(),
      ),
    );
  }
}
