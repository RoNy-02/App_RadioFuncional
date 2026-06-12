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
  extendBodyBehindAppBar: true, // 🔥 FIX

  backgroundColor: Colors.white, // 🔥 evita fondo blanco

  appBar: PreferredSize(
    preferredSize: const Size.fromHeight(90), // 🔥 ajustado
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AppBar(
            toolbarHeight: 80,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            automaticallyImplyLeading: false,

            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/appbar.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),

            title: Image.asset(
              "assets/images/Navbar_logo.png",
              height: 100, // 🔥 FIX
            ),
            centerTitle: true,
          ),
        ),
      ),
    ),
  ),


      drawer: Drawer(
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          removeTop: true,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 255, 208, 0),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/Navbar_logo.png",
                      fit: BoxFit.contain,
                      height: 200, //  control tamaño
                    ),
                  ),
                ),
              ), 
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
                await Share.share(
                  '¡Escucha nuestra app de radio! Descárgala aquí: https://play.google.com/store/apps/details?id=com.radioactivatx.radio',
                  subject: 'Recomendación de app',
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('¡Califica nuestra app!'),
              onTap: () {
                Navigator.pop(context);
                _launchURL(
                    'market://details?id=com.radioactivatx.radio');
              },
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Nuestra Misión'),
              onTap: () {
                Navigator.pop(context);
                _launchURL(
                    'https://www.radioactivatx.org/acerca-de/');
              },
            ),

            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Política de Privacidad'),
              onTap: () {
                Navigator.pop(context);
                _launchURL(
                    'https://www.radioactivatx.org/politica-privacidad/');
              },
            ),

            ListTile(
              leading: const Icon(Icons.radio),
              title: const Text('Escúchanos en'),
              onTap: () {
                Navigator.pop(context);
                _launchURL(
                    'https://www.radioactivatx.org/streaming/');
              },
            ),

            const ListTile(
              leading: Icon(Icons.update),
              title: Text("Versión 1.0.0"),
            ),
          ],
        ),
      )),

      // MINI PLAYER
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: const ProgramCarousel(),
            ),
          ),

          //  MINI PLAYER
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MiniPlayer(),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri,
            mode: LaunchMode.externalApplication);
      } else {
        debugPrint('No se pudo abrir: $url');
      }
    } catch (e) {
      debugPrint('Error al abrir $url: $e');
    }
  }
}