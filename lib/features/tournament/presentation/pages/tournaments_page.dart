import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TournamentsPage extends StatelessWidget {
  const TournamentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournois'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 16.h),
            child: Column(
              children: [
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.emoji_events,
                      size: 48.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tournoi de Printemps ${index + 1}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Participez à notre tournoi mensuel et gagnez des récompenses exceptionnelles !',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Participants',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '${(index + 1) * 10}/50',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implémenter l'inscription au tournoi
                            },
                            child: const Text('Participer'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
