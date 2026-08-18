import '../../drive/domain/entities/route_analysis.dart';

class SavedPlace {
  const SavedPlace({required this.name, required this.coord});

  final String name;
  final Coord coord;

  Map<String, dynamic> toJson() => {
    'name': name,
    'lat': coord.lat,
    'lon': coord.lon,
  };

  factory SavedPlace.fromJson(Map<String, dynamic> json) => SavedPlace(
    name: json['name'] as String,
    coord: Coord(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    ),
  );
}
