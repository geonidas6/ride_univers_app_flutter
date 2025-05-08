import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'stats_card.dart';

class UserStatsGrid extends StatelessWidget {
  final double totalDistance;
  final Duration totalDuration;
  final int totalRides;
  final double averageSpeed;
  final int totalElevation;
  final int achievements;

  const UserStatsGrid({
    super.key,
    required this.totalDistance,
    required this.totalDuration,
    required this.totalRides,
    required this.averageSpeed,
    required this.totalElevation,
    required this.achievements,
  });

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    return '$hours h';
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.w),
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      children: [
        StatsCard(
          title: 'Distance Totale',
          value: '${totalDistance.toStringAsFixed(0)} km',
          icon: Icons.timeline,
          color: Colors.blue,
        ),
        StatsCard(
          title: 'Temps Total',
          value: _formatDuration(totalDuration),
          icon: Icons.timer,
          color: Colors.orange,
        ),
        StatsCard(
          title: 'Nombre de Rides',
          value: totalRides.toString(),
          icon: Icons.directions_bike,
          color: Colors.green,
        ),
        StatsCard(
          title: 'Vitesse Moyenne',
          value: '${averageSpeed.toStringAsFixed(1)} km/h',
          icon: Icons.speed,
          color: Colors.purple,
        ),
        StatsCard(
          title: 'Dénivelé Total',
          value: '${totalElevation}m',
          icon: Icons.terrain,
          color: Colors.brown,
        ),
        StatsCard(
          title: 'Réalisations',
          value: achievements.toString(),
          icon: Icons.emoji_events,
          color: Colors.amber,
        ),
      ],
    );
  }
}
