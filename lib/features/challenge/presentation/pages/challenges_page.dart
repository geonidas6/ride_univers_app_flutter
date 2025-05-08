import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Défis'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'En cours'),
              Tab(text: 'Terminés'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildChallengesList(true),
            _buildChallengesList(false),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesList(bool isActive) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Défi #${index + 1}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        isActive ? 'En cours' : 'Terminé',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Parcourir 100km en vélo',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                if (isActive)
                  LinearProgressIndicator(
                    value: (index + 1) * 0.2,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                SizedBox(height: 8.h),
                Text(
                  isActive
                      ? 'Progression: ${((index + 1) * 20)}%'
                      : 'Récompense: 100 points',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
