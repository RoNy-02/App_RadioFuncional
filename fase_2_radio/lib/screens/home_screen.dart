import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fase_2_radio/widgets/program_carousel.dart';
import 'package:fase_2_radio/widgets/mini_player.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/appbar.jpg"), fit: BoxFit.cover),
              ),
            ),
            elevation: 15,
            centerTitle: true,
            titleTextStyle: const TextStyle(fontSize:20),
            title: const Text("RadiactivaX", style: TextStyle(fontFamily:"Roboto",fontWeight: FontWeight.bold,fontSize: 40),),
            backgroundColor: Color.fromARGB(255, 84, 0, 253),
            shadowColor: const Color.fromARGB(255, 7, 83, 214),
            actions: const [Icon(Icons.more_vert, color: Color(0xffffffff))],
          ),
        ),
      ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 20, 20),
                  border: Border(top: BorderSide(color: Colors.white38)),
                  image: DecorationImage(image: AssetImage("assets/images/logo_drawer.png"),
                  fit: BoxFit.cover
                  )
                ),
                child: Text("RadioActiva",style: TextStyle(fontSize: 20, color: Color(0xffffffff), fontFamily: "Roboto")),
              ),
              const ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text("Modo oscuro"),
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Comparte con un amigo'),
                onTap: () async {
                  Navigator.pop(context);
                  await Share.share('¡Escucha nuestra app de radio! Descárgala aquí: https://play.google.com/store/apps/details?id=com.radioactivatx.radio', subject: 'Recomendación de app');
                },
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: const Text('¡Califica nuestra app!'),
                onTap: () {
                Navigator.pop(context);

                _launchURL('market://details?id=com.radioactivatx.radio');
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: const Text('Nuestra Misión'),
                onTap: () {
                Navigator.pop(context);
                _launchURL('https://www.radioactivatx.org/acerca-de/');
              },
            ),
              ListTile(
                leading: Icon(Icons.description),
                title: const Text('Política de Privacidad'),
                onTap: () {
                Navigator.pop(context);
                _launchURL(
                  'https://www.radioactivatx.org/politica-privacidad/',
                );
              },
            ),
              ListTile(
                leading: Icon(Icons.radio),
                title: const Text('Escúchanos en'),
                onTap: () {
                Navigator.pop(context);
                _launchURL('https://www.radioactivatx.org/streaming/');
              },
            ),
              const ListTile(
                leading: Icon(Icons.update),
                title: Text("Versión 1.0.0"),
              ),
            ]
          ),
        ),
        //CARRUSEL Y MINI PLAYER
        body: Stack(
          children: [
            SingleChildScrollView(//agregando para que el reproductor no tape las redes sociales
              child: Padding(
                padding: const EdgeInsets.only(bottom: 110),
                child: ProgramCarousel(),
              ),
            ),
            // Mini Player en la parte inferior
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MiniPlayer(),
            ),
          ],
        )
        );
    }
  }

  Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    if (await canLaunchUrl(uri)) {//se uso url_launcher en dependencias
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('ERROR: No se pudo lanzar la URL: $url');
    }
  } catch (e) {
    debugPrint('Excepción al lanzar URL $url: $e');
  }
}