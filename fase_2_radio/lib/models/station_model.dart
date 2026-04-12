//datos de la estacion
class StationModel {
  final String id;
  final String name;
  final String acronym;
  final String Url;
  final String slogan;
  final String image;
  final String? imageUrl;
  final Map<String, String> socials;

  StationModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.Url,
    required this.slogan,
    required this.image,
    this.imageUrl,
    this.socials = const {},
  });
}
