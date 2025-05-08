import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../ride/presentation/pages/rides_page.dart';
import '../../../tournament/presentation/pages/tournaments_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../challenge/presentation/pages/challenges_page.dart';
import '../../../ride/presentation/bloc/ride_bloc.dart';
import '../../../ride/presentation/bloc/ride_event.dart';
import '../../../ride/presentation/bloc/ride_state.dart';
import '../../../ride/domain/entities/ride.dart';
import '../widgets/user_stats_grid.dart';
import '../widgets/recent_rides_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const RidesPage(),
    const TournamentsPage(),
    const ChallengesPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<RideBloc>().add(LoadRides());
  }

  double _calculateTotalDistance(List<Ride> rides) {
    return rides.fold(0.0, (sum, ride) => sum + ride.distance);
  }

  Duration _calculateTotalDuration(List<Ride> rides) {
    return rides.fold(
      Duration.zero,
      (sum, ride) => sum + ride.duration,
    );
  }

  double _calculateAverageSpeed(List<Ride> rides) {
    if (rides.isEmpty) return 0.0;
    final totalSpeed = rides.fold(
      0.0,
      (sum, ride) => sum + ride.averageSpeed,
    );
    return totalSpeed / rides.length;
  }

  int _calculateTotalElevation(List<Ride> rides) {
    return rides.fold(0, (sum, ride) => sum + ride.elevation);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToRideDetails(BuildContext context, Ride ride) {
    Navigator.pushNamed(
      context,
      '/ride/details',
      arguments: ride,
    );
  }

  void _navigateToCreateRide(BuildContext context) {
    Navigator.pushNamed(context, '/ride/create');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          return Scaffold(
            body: BlocBuilder<RideBloc, RideState>(
              builder: (context, state) {
                if (state is RidesLoaded) {
                  final rides = state.rides;
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<RideBloc>().add(LoadRides());
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.r),
                                bottomRight: Radius.circular(30.r),
                              ),
                            ),
                            child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bonjour, ${authState.user.prenoms}',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Voici vos statistiques',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          UserStatsGrid(
                            totalDistance: _calculateTotalDistance(rides),
                            totalDuration: _calculateTotalDuration(rides),
                            totalRides: rides.length,
                            averageSpeed: _calculateAverageSpeed(rides),
                            totalElevation: _calculateTotalElevation(rides),
                            achievements: 0, // À implémenter plus tard
                          ),
                          RecentRidesList(
                            rides: rides.take(5).toList(),
                            onRideTap: (ride) =>
                                _navigateToRideDetails(context, ride),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is RideError) {
                  return Center(
                    child: Text(
                      'Erreur: ${state.message}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'startRide',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/ride/tracker'),
                  icon: const Icon(Icons.directions_bike),
                  label: const Text('Commencer un trajet'),
                  backgroundColor: Colors.orange,
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: 'addRide',
                  onPressed: () => _navigateToCreateRide(context),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_bike),
                  label: 'Rides',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events),
                  label: 'Tournois',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.flag),
                  label: 'Défis',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
