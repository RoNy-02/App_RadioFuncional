import 'package:fase_2_radio/models/station_model.dart';
import 'package:fase_2_radio/widgets/station_card.dart';
import 'package:fase_2_radio/helpers/providers/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          GalleryCarousel(),
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
  
  final Stations = [
    Station(
      name: "RadioActiva",
      url: "https://stream.freepi.io:8010/stream",
      image: "assets/icons/RadioActivaStation.webp",
    ),
    Station(
      name: "Live Jazz Radio",
      url: "https://stream.freepi.io/8012/live",
      image: "assets/icons/LIVEJAZZ_RADIO_-_CDMX.webp",
    )
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
                audio.playRadio(Stations[index].url, Stations[index].name);
              } else {
                audio.setRadio(Stations[index].url, Stations[index].name);
              }
            },
            itemCount: Stations.length,
            itemBuilder: (context, index) {
              return EstacionCard(station: Stations[index]);
            },
          ),
        ),
      ],
    );
  }
}

// Carrusel destacados
class FeaturedCarousel extends StatefulWidget {
  const FeaturedCarousel({super.key});  
  
  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  int _currentIndex = 0;
  late PageController _pageController;
  
  final images = [
    'assets/images/header.jpg',
    'assets/images/header2.jpg',
    'assets/images/imagen1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: images.length * 500);
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            'Destacados',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % images.length;
              });
            },
            itemCount: images.length * 10000,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    images[index % images.length],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}

// Carrusel galería
class GalleryCarousel extends StatefulWidget {
  const GalleryCarousel({super.key});  
  
  @override
  State<GalleryCarousel> createState() => _GalleryCarouselState();
}

class _GalleryCarouselState extends State<GalleryCarousel> {
  int _currentIndex = 0;
  late PageController _pageController;
  
  final images = [
    'assets/images/splash1.png',
    'assets/images/splash2.png',
    'assets/images/splash3.png',
    'assets/images/splash4.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: images.length * 500);
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            'Galería',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % images.length;
              });
            },
            itemCount: images.length * 10000,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    images[index % images.length],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }
}