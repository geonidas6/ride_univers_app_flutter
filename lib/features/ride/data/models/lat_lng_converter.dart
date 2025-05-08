import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

class LatLngListConverter
    implements JsonConverter<List<LatLng>, List<dynamic>> {
  const LatLngListConverter();

  @override
  List<LatLng> fromJson(List<dynamic> json) {
    return json.map((item) {
      final list = item as List<dynamic>;
      return LatLng(list[0] as double, list[1] as double);
    }).toList();
  }

  @override
  List<dynamic> toJson(List<LatLng> latLngs) {
    return latLngs
        .map((latLng) => [latLng.latitude, latLng.longitude])
        .toList();
  }
}
