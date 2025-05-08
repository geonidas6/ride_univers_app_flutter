import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RidesPage extends StatelessWidget {
  const RidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Rides'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implémenter la création de ride
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 10, // TODO: Remplacer par la vraie liste des rides
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 16.h),
            child: ListTile(
              leading: const Icon(Icons.directions_bike),
              title: Text('Ride #${index + 1}'),
              subtitle: Text('Distance: ${(index + 1) * 5} km'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Naviguer vers les détails du ride
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implémenter la création de ride
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
