import 'package:fase_2_radio/models/station_model.dart';
import 'package:fase_2_radio/models/program_model.dart';
import 'package:fase_2_radio/widgets/station_card.dart';
import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fase_2_radio/helpers/utills.dart';
import 'package:url_launcher/url_launcher.dart';

// Widget contenedor con todos los carruseles
class ProgramCarousel extends StatelessWidget {
  const ProgramCarousel({super.key});  
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RadioStationsCarousel(),
          FeaturedCarousel(),
          SocialMediaButtons()
        ],
      ),
    );
  }
}

// Carrusel de estaciones de radio
class RadioStationsCarousel extends StatefulWidget {
  const RadioStationsCarousel({super.key});  
  
  @override
  State<RadioStationsCarousel> createState() => _RadioStationsCarouselState();
}

class _RadioStationsCarouselState extends State<RadioStationsCarousel> {
  int _currentIndex = 0;
  late PageController _pageController;
  


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            'Estaciones de Radio',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Carrusel con altura fija
        Column(
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  // Cambiar la estación al deslizar
                  final audio = context.read<AudioProvider>();
                  // Si está reproduciendo, reproducir la nueva; si está pausada, solo cargar
                  if (audio.isPlaying) {
                    audio.playRadio(Stations[index].Url, Stations[index].name);
                  } else {
                    audio.setRadio(Stations[index].Url, Stations[index].name);
                  }
                },
                itemCount: Stations.length,
                itemBuilder: (context, index) {
                  return EstacionCard(station: Stations[index]);
                },
              ),
            ),
            // Indicadores de página
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  Stations.length,
                  (index) => Container(
                    height: 8,
                    width: _currentIndex == index ? 24 : 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Theme.of(context).primaryColor
                          : const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Carrusel destacados - Programas
class FeaturedCarousel extends StatefulWidget {
  const FeaturedCarousel({super.key});  
  
  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  int _currentIndex = 0;
  late PageController _pageController;
  
  final List<ProgramModel> programs = [
    ProgramModel(id: 'p1', title: 'Mañana Alternativa', description: 'Rock alternativo y entrevistas exclusivas. Disfruta de las mejores bandas y conoce historias detrás de la música. Ideal para empezar el día con energía y buena vibra.', schedule: {'Lunes': '08:00 - 10:00'}, image: 'assets/images/Program1.jpg'),
    ProgramModel(id: 'p2', title: 'Tarde Indie', description: 'Indie, electrónica y tendencias underground. Descubre nuevos sonidos y artistas emergentes.', schedule: {'Lunes': '16:00 - 18:00'}, image: 'assets/images/Program2.jpg'),
    ProgramModel(id: 'p3', title: 'Jazz Fusion', description: 'Jazz experimental y fusiones modernas. Un espacio para los amantes de la improvisación.', schedule: {'Martes': '10:00 - 12:00'}, image: 'assets/images/Program3.jpg'),
    ProgramModel(id: 'p4', title: 'Noches Urbanas', description: 'Hip-hop, rap y cultura urbana. Ritmos intensos y letras que cuentan historias.', schedule: {'Martes': '20:00 - 22:00'}, image: 'assets/images/Program4.jpg'),
    ProgramModel(id: 'p5', title: 'Electro Vibes', description: 'Electrónica y dance para mitad de semana. Sube el volumen y déjate llevar.', schedule: {'Miércoles': '18:00 - 20:00'}, image: 'assets/images/Program5.jpg'),
    ProgramModel(id: 'p6', title: 'Retro Hits', description: 'Clásicos de los 80s y 90s. Revive los éxitos que marcaron época.', schedule: {'Jueves': '14:00 - 16:00'}, image: 'assets/images/Program6.jpg'),
    ProgramModel(id: 'p7', title: 'Fiesta Latina', description: 'Reggaetón, salsa y ritmos latinos. La mejor fiesta para arrancar el fin de semana.', schedule: {'Viernes': '20:00 - 23:00'}, image: 'assets/images/Program7.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 12), child: Text('Nuestros Programas', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),
        Column(
          children: [
            SizedBox(
              height: 400,//tamaño del carrusel
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentIndex = index % programs.length),
                itemCount: programs.length * 10000,
                itemBuilder: (context, index) {
                  final program = programs[index % programs.length];
                  return GestureDetector(
                    onTap: () => _showProgramDialog(context, program, primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(
                        children: [
                          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(program.image, fit: BoxFit.cover, width: double.infinity, errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]))),
                          Positioned(bottom: 0, left: 0, right: 0, child: Container(
                            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black87])),
                            padding: const EdgeInsets.all(12),
                            child: Text(program.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(programs.length, (index) => Container(
                  height: 8, width: _currentIndex % programs.length == index ? 24 : 8, margin: const EdgeInsets.symmetric(horizontal: 4),
                   decoration: BoxDecoration(color: _currentIndex % programs.length == index ? primaryColor : Colors.grey[400], borderRadius: BorderRadius.circular(4)))),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showProgramDialog(BuildContext context, ProgramModel program, Color primaryColor) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                  child: Image.asset(
                    program.image,
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey[300], height: 280),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(program.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                      const SizedBox(height: 12),
                      Text(program.description, style: const TextStyle(color: Colors.black87, fontSize: 15)),
                      const SizedBox(height: 16),
                      Text('Horarios de Emisión', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: program.schedule.entries.map((e) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: primaryColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: primaryColor, width: 1.5)),
                          child: Text('${e.key}\n${e.value}', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                        )).toList(),
                      ),
                      const SizedBox(height: 16),
                      Text('Estación: RadioActiva TX', style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  final List<Map<String, dynamic>> socialLinks = const [
    {
      'name': 'Instagram',
      'assetPath': 'assets/icons/Instagram.png',
      'color': Color(0xFFC13584),
      'backgroundColor': Color(0xFFC13584),
      'url': 'https://www.instagram.com/radioactivatx?igsh=M2piYzc1eGNiY29v',
    },
    {
      'name': 'Facebook',
      'assetPath': 'assets/icons/Facebook.png',
      'color': Color(0xFF3B5998),
      'backgroundColor': Color(0xFF3B5998),
      'url':
          'https://www.facebook.com/radioactivatx89.9?wtsid=rdr_01btUDnQhVaGthwGL&from_intent_redirect=1',
    },
    {
      'name': 'X (Twitter)',
      'assetPath': 'assets/icons/Twiter.png',
      'color': Colors.black,
      'backgroundColor': Colors.black,
      'url': 'https://twitter.com/RadioactivaTx',
    },
    {
      'name': 'YouTube',
      'assetPath': 'assets/icons/Youtube.png',
      'color': Color(0xFFFF0000),
      'backgroundColor': Color(0xFFFF0000),
      'url': 'https://youtube.com/@radioactivatx?si=AZwNbDJzsPoLlxDB',
    },
    {
      'name': 'Tik Tok',
      'assetPath': 'assets/icons/Tiktok.png',
      'color': Color.fromARGB(255, 10, 10, 10),
      'backgroundColor': Color.fromARGB(255, 10, 10, 10),
      'url': 'https://www.tiktok.com/@radioactiva.tx?_r=1&_t=ZS-91jAkaMrlyP',
    },
    {
      'name': 'Teléfono',
      'assetPath': 'assets/icons/Telefono.png',
      'color': Colors.lightBlue,
      'backgroundColor': Colors.lightBlue,
      'url': 'tel:+524141199003',
    },
    {
      'name': 'Web',
      'assetPath': 'assets/icons/Web.png',
      'color': Color.fromARGB(255, 11, 11, 11),
      'backgroundColor': Color.fromARGB(255, 11, 11, 11),
      'url': 'https://www.radioactivatx.org/',
    },
  ];

  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      print('Intentando abrir: $urlString');
      
      if (await canLaunchUrl(url)) {
        final bool launched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
        if (launched) {
          print('URL abierta exitosamente: $urlString');
        } else {
          print('No se pudo lanzar la URL: $urlString');
        }
      } else {
        print('No hay app disponible para: $urlString. Intentando con modo platformDefault...');
        try {
          await launchUrl(
            url,
            mode: LaunchMode.platformDefault,
          );
          print('URL abierta en modo por defecto: $urlString');
        } catch (e) {
          print('Error en modo por defecto: $e');
        }
      }
    } catch (e) {
      print('Error al procesar URL: $urlString - Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Wrap(
          spacing: 15.0,
          runSpacing: 15.0,
          alignment: WrapAlignment.center,
          children: socialLinks.map((link) {
            final color = link['color'] as Color;
            final assetPath = link['assetPath'] as String;
            final name = link['name'] as String;

            return InkWell(
              onTap: () async {
                await _launchURL(link['url'] as String);
              },
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        assetPath,
                        width: 40,
                        height: 40,

                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.link, size: 40, color: color),
                      ),
                      const SizedBox(height: 2),

                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  }