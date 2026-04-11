import 'package:fase_2_radio/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 30,
      fontWeight: FontWeight.w700
      ),
      bodyTextStyle: TextStyle(fontSize: 20),
      bodyPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: const Color.fromARGB(255, 255, 255, 255),
      imagePadding: EdgeInsets.zero
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Escucha ahora",
          body: "La vieja confiable...",
          image: Image.asset("assets/images/splash1.png", width: 200,),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Estaciones que te haran sentir vivo",
          body: "Escuchalos donde quieras",
          image: Image.asset("assets/images/splash2.png", width: 200,),
          decoration: pageDecoration,
        ),
        //Boton de notificaciones-mofiicar el ancho
        PageViewModel(
          title: "Activa las notificaciones",
          body: "Recibe notificaciones para no perder novedades",
          image: Image.asset("assets/images/splash3.png", width: 200,),
          decoration: pageDecoration,
          footer: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(250, 50),//moficar esto para centrar
            backgroundColor: Colors.blueGrey),
            onPressed:() async {
              final status = await Permission.notification.request();
              if(status.isGranted){
                print("Permiso concedido");
              } else if(status.isDenied){
                print("Permiso denegado");
              }
            }, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_active,
                  color: Colors.white,),
                  Text("Activa las notificaciones",
                  style: TextStyle(color: Colors.white),)
                ]
              ),
            ),//poner un icono al boton
              //style: ElevatedButton.styleFrom(
              //  minimumSize: Size.fromHeight(50),
              //  backgroundColor: const Color.fromARGB(143, 167, 172, 184),
                
        ),
        PageViewModel(
          title: "Estaciones 24/7",
          body: "Siempre activos.",
          image: Image.asset("assets/images/splash4.png", width: 200,),
          decoration: pageDecoration,
          ),
          
      ],
      
      showSkipButton: true,
      showDoneButton: true,
      showBackButton: true,
        back: Text("Regresar",style:
         TextStyle(fontWeight: 
         FontWeight.w600,color: 
         const Color.fromARGB(255, 139, 159, 159)),),
        next: Text("Siguiente",style:
         TextStyle(fontWeight: 
         FontWeight.w600,color: 
         Colors.blueGrey),),
        done: Text("Hecho",style:
         TextStyle(fontWeight: 
         FontWeight.w600,color: 
         Colors.blueGrey),
         ),
        skip: Text("Omitir",style:
         TextStyle(fontWeight:
        FontWeight.w600, color:
         Colors.blueGrey),),
      onDone: () async {
        await _saveOnBoardingSeen();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));},//verificar ya no vuelva a aparecer

      onSkip: () async {
        await _saveOnBoardingSeen();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));//pushreplacement para que no vuelva atras despues de skip
      },
      dotsDecorator: DotsDecorator(
        size: Size.square(10),
        activeSize: Size(20, 10),
        activeColor: Color.fromARGB(255, 82, 88, 90),
        color: Colors.black,
        spacing: EdgeInsets.symmetric(horizontal: 3),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        )
      ),
      
    );
  }
}

Future<void> _saveOnBoardingSeen() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("onboardingSeen", true);
}