import 'package:audio_service/audio_service.dart';
import 'package:fase_2_radio/screens/splash_screen.dart';
import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await JustAudioBackground.init(
      androidNotificationChannelId: "com.ejemplo.radio.channel.audio",
      androidNotificationChannelName: "Reproducción de Audio",
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: true,
      androidNotificationClickStartsActivity: true,
    );
  } catch (e) {
    print('Error al inicializar JustAudioBackground: $e');
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
