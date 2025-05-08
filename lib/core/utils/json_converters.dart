import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

class LatLngListConverter
    implements JsonConverter<List<LatLng>, List<dynamic>> {
  const LatLngListConverter();

  @override
  List<LatLng> fromJson(List<dynamic> json) {
    return json.map((point) {
      final Map<String, dynamic> latLng = point as Map<String, dynamic>;
      return LatLng(
        latLng['latitude'] as double,
        latLng['longitude'] as double,
      );
    }).toList();
  }

  @override
  List<Map<String, double>> toJson(List<LatLng> path) {
    return path
        .map((latLng) => {
              'latitude': latLng.latitude,
              'longitude': latLng.longitude,
            })
        .toList();
  }
}

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) => Duration(seconds: json);

  @override
  int toJson(Duration duration) => duration.inSeconds;
}
