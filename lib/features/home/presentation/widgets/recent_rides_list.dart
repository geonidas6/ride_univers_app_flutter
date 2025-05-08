import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../ride/domain/entities/ride.dart';

class RecentRidesList extends StatelessWidget {
  final List<Ride> rides;
  final Function(Ride) onRideTap;

  const RecentRidesList({
    super.key,
    required this.rides,
    required this.onRideTap,
  });

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}min';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            'Derniers Trajets',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rides.length,
          itemBuilder: (context, index) {
            final ride = rides[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: ListTile(
                leading: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.directions_bike,
                    color: Theme.of(context).primaryColor,
                    size: 24.sp,
                  ),
                ),
                title: Text(
                  ride.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${ride.distance.toStringAsFixed(1)} km • ${_formatDuration(ride.duration)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'Vitesse moy. ${ride.averageSpeed.toStringAsFixed(1)} km/h',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
                onTap: () => onRideTap(ride),
              ),
            );
          },
        ),
      ],
    );
  }
}
