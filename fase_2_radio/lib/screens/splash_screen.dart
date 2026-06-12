import 'package:fase_2_radio/screens/home_screen.dart';
import 'package:fase_2_radio/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    init();//

    WidgetsBinding.instance.addPostFrameCallback((_){
      _checkOnboarding();
    });

    //causa conflicto con el splash screen
    /*Timer(Duration(seconds:5),
    ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen(),))
    );*/
  }
  
  Future<void> init() async{
    initializeTimeZones();
    

    setLocalLocation(getLocation('America/Mexico_City')
    );
    const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
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
            image: AssetImage("assets/images/fondo.jpg"),//imagen del splash
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.amberAccent.withOpacity(0.3), BlendMode.darken)
             //para que se amplie la imagen
            //opacity:0.4
          )
        ),
      child: Center(
        heightFactor: 2.0,
        
        child: Image.asset("assets/images/logo_drawer.png",
        
        width: 400,height: 200,),
      )
      )
    );
  }
Future<void> _checkOnboarding()async{
  final prefers = await SharedPreferences.getInstance();
  final seen = prefers.getBool('onboardingSeen') ?? false;
      

  await Future.delayed(Duration(seconds: 5));// tiempo del splash-tiene que estar al mismo tiempo de segundos que el time de arriba
  if (seen){//verificar que ya se vio el onboardin, si es asi se va a homescreen directamente
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
  }else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> OnboardingScreen()));
  }
  }
}