import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/ride.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class RideDetailsPage extends StatelessWidget {
  final Ride ride;

  const RideDetailsPage({
    super.key,
    required this.ride,
  });

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}min';
  }

  @override
  Widget build(BuildContext context) {
    final mapController = MapController.withPosition(
      initPosition: ride.path.isNotEmpty
          ? GeoPoint(
              latitude: ride.path.first.latitude,
              longitude: ride.path.first.longitude,
            )
          : GeoPoint(latitude: 0, longitude: 0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(ride.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: OSMFlutter(
              controller: mapController,
              osmOption: OSMOption(
                zoomOption: ZoomOption(
                  initZoom: 14,
                  minZoomLevel: 2,
                  maxZoomLevel: 18,
                  stepZoom: 1.0,
                ),
                userTrackingOption: UserTrackingOption(
                  enableTracking: false,
                  unFollowUser: false,
                ),
                roadConfiguration: RoadOption(
                  roadColor: Theme.of(context).primaryColor,
                  roadWidth: 3.0,
                ),
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.navigation,
                      color: Colors.blue,
                      size: 48,
                    ),
                  ),
                ),
              ),
              onMapIsReady: (isReady) async {
                if (isReady && ride.path.length > 1) {
                  await mapController.drawRoadManually(
                    ride.path
                        .map((p) => GeoPoint(
                              latitude: p.latitude,
                              longitude: p.longitude,
                            ))
                        .toList(),
                    RoadOption(
                      roadColor: Theme.of(context).primaryColor,
                      roadWidth: 3.0,
                    ),
                  );
                  // Ajoute les marqueurs de début et de fin
                  await mapController.addMarker(
                    GeoPoint(
                      latitude: ride.path.first.latitude,
                      longitude: ride.path.first.longitude,
                    ),
                    markerIcon: const MarkerIcon(
                      icon: Icon(Icons.flag, color: Colors.green, size: 40),
                    ),
                  );
                  if (ride.path.length > 1) {
                    await mapController.addMarker(
                      GeoPoint(
                        latitude: ride.path.last.latitude,
                        longitude: ride.path.last.longitude,
                      ),
                      markerIcon: const MarkerIcon(
                        icon: Icon(Icons.flag, color: Colors.red, size: 40),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Statistiques',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildStatRow(
                    'Distance',
                    '${ride.distance.toStringAsFixed(1)} km',
                    Icons.timeline,
                  ),
                  _buildStatRow(
                    'Durée',
                    _formatDuration(ride.duration),
                    Icons.timer,
                  ),
                  _buildStatRow(
                    'Vitesse moyenne',
                    '${ride.averageSpeed.toStringAsFixed(1)} km/h',
                    Icons.speed,
                  ),
                  _buildStatRow(
                    'Vitesse max',
                    '${ride.maxSpeed.toStringAsFixed(1)} km/h',
                    Icons.trending_up,
                  ),
                  _buildStatRow(
                    'Dénivelé',
                    '${ride.elevation}m',
                    Icons.terrain,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Détails',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildDetailRow('Type', ride.type.toString().split('.').last),
                  _buildDetailRow(
                    'Difficulté',
                    ride.difficulty.toString().split('.').last,
                  ),
                  _buildDetailRow(
                    'Date',
                    ride.startTime.toString().split('.').first,
                  ),
                  _buildDetailRow(
                    'Participants',
                    '${ride.participants.length} cycliste(s)',
                  ),
                  _buildDetailRow('Likes', ride.likes.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 24.sp),
          SizedBox(width: 16.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
