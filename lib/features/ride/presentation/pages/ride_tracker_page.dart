import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ride.dart';
import '../bloc/ride_bloc.dart';
import '../bloc/ride_event.dart';
import '../../../../services/notification_service.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class RideTrackerPage extends StatefulWidget {
  const RideTrackerPage({super.key});

  @override
  State<RideTrackerPage> createState() => _RideTrackerPageState();
}

class _RideTrackerPageState extends State<RideTrackerPage> {
  bool isTracking = false;
  List<latlong.LatLng> path = [];
  DateTime? startTime;
  DateTime? endTime;
  double totalDistance = 0;
  double currentSpeed = 0;
  Timer? timer;
  StreamSubscription<Position>? positionStream;
  Duration elapsed = Duration.zero;
  late final MapController mapController = MapController.withUserPosition(
    trackUserLocation: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  @override
  void dispose() {
    positionStream?.cancel();
    timer?.cancel();
    super.dispose();
  }

  void startTracking() async {
    setState(() {
      isTracking = true;
      startTime = DateTime.now();
      path.clear();
      totalDistance = 0;
      currentSpeed = 0;
      elapsed = Duration.zero;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsed = DateTime.now().difference(startTime!);
      });
    });
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    ).listen((position) {
      final latLng = latlong.LatLng(position.latitude, position.longitude);
      setState(() {
        if (path.isNotEmpty) {
          totalDistance += Geolocator.distanceBetween(
            path.last.latitude,
            path.last.longitude,
            latLng.latitude,
            latLng.longitude,
          );
        }
        path.add(latLng);
        currentSpeed = position.speed * 3.6; // m/s -> km/h
      });
    });
  }

  void stopTracking() {
    setState(() {
      isTracking = false;
      endTime = DateTime.now();
    });
    positionStream?.cancel();
    timer?.cancel();
    if (path.length < 2) {
      NotificationService.showSnackBar(
        context: context,
        message: 'Trace trop courte',
        type: NotificationType.warning,
      );
      return;
    }
    // Envoi du trajet au backend via le bloc
    context.read<RideBloc>().add(
          CreateRide(
            Ride(
              id: '',
              title:
                  'Trajet du ${startTime?.toLocal().toString().split(" ")[0] ?? ''}',
              description: '',
              distance: totalDistance / 1000, // en km
              duration: elapsed,
              averageSpeed: totalDistance > 0
                  ? (totalDistance / elapsed.inSeconds) * 3.6
                  : 0,
              maxSpeed: 0, // à calculer si besoin
              elevation: 0, // à calculer si besoin
              path: path
                  .map((e) => latlong.LatLng(e.latitude, e.longitude))
                  .toList(),
              startTime: startTime!,
              endTime: endTime,
              status: RideStatus.completed,
              type: RideType.road,
              difficulty: RideDifficulty.beginner,
              participants: const [],
              likes: 0,
              userId: '',
              imageUrl: null,
              createdAt: startTime!,
              updatedAt: endTime!,
            ),
          ),
        );
    NotificationService.showSnackBar(
      context: context,
      message: 'Trajet enregistré',
      type: NotificationType.success,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suivi de Trajet')),
      body: Stack(
        children: [
          // Affiche la carte OSMFlutter en fond
          Positioned.fill(
            child: Container(
              height: 300,
              child: OSMFlutter(
                controller: mapController,
                osmOption: const OSMOption(
                  zoomOption: const ZoomOption(
                    initZoom: 16,
                    minZoomLevel: 2,
                    maxZoomLevel: 18,
                    stepZoom: 1.0,
                  ),
                  userTrackingOption: UserTrackingOption(
                    enableTracking: true,
                    unFollowUser: false,
                  ),
                  showZoomController: true,  // Cette ligne active les contrôleurs de zoom
                  showDefaultInfoWindow: false,
                  showContributorBadgeForOSM: false,
                  enableRotationByGesture: true,
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('Distance',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${(totalDistance / 1000).toStringAsFixed(2)} km'),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Vitesse',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${currentSpeed.toStringAsFixed(1)} km/h'),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Temps',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            '${elapsed.inMinutes.toString().padLeft(2, '0')}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: isTracking
          ? FloatingActionButton(
              onPressed: stopTracking,
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            )
          : FloatingActionButton(
              onPressed: startTracking,
              backgroundColor: Colors.green,
              child: const Icon(Icons.play_arrow),
            ),
    );
  }
}
