import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

class LatLngListConverter
    implements JsonConverter<List<LatLng>, List<dynamic>> {
  const LatLngListConverter();

  @override
  List<LatLng> fromJson(List<dynamic> json) {
    return json.map((item) {
      final map = item as Map<String, dynamic>;
      return LatLng(
        map['latitude'] as double,
        map['longitude'] as double,
      );
    }).toList();
  }

  @override
  List<dynamic> toJson(List<LatLng> latLngList) {
    return latLngList.map((latLng) {
      return {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      };
    }).toList();
  }
}
