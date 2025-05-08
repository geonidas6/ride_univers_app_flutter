import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Les permissions de localisation sont définitivement refusées.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static double calculateDistance(List<LatLng> path) {
    double totalDistance = 0;
    for (int i = 0; i < path.length - 1; i++) {
      totalDistance += Geolocator.distanceBetween(
        path[i].latitude,
        path[i].longitude,
        path[i + 1].latitude,
        path[i + 1].longitude,
      );
    }
    return totalDistance / 1000; // Convertir en kilomètres
  }

  static Duration estimateDuration(
      double distanceInKm, double averageSpeedKmH) {
    if (averageSpeedKmH <= 0) return const Duration(minutes: 0);
    double hours = distanceInKm / averageSpeedKmH;
    return Duration(minutes: (hours * 60).round());
  }

  static Future<int> calculateElevation(List<LatLng> path) async {
    // TODO: Implémenter le calcul du dénivelé avec un service d'élévation
    return 0;
  }

  static Future<List<LatLng>> getRouteCoordinates(
    LatLng start,
    LatLng end, {
    List<String>? wayPoints,
    String googleApiKey =
        '456268739233-bo7oc1i29a8djejqvr6ikuc1pc9i86a0.apps.googleusercontent.com',
  }) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleApiKey,
      request: PolylineRequest(
        origin: PointLatLng(start.latitude, start.longitude),
        destination: PointLatLng(end.latitude, end.longitude),
        mode: TravelMode.bicycling,
        wayPoints: wayPoints != null
            ? wayPoints.map((loc) => PolylineWayPoint(location: loc)).toList()
            : [],
      ),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    return polylineCoordinates;
  }
}
