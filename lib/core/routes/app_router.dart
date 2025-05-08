import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/ride/domain/entities/ride.dart';
import '../../features/ride/presentation/pages/ride_details_page.dart';
import '../../features/ride/presentation/pages/create_ride_page.dart';
import '../../features/ride/presentation/pages/ride_tracker_page.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/ride/create':
        return MaterialPageRoute(builder: (_) => const CreateRidePage());
      case '/ride/details':
        final ride = settings.arguments as Ride;
        return MaterialPageRoute(
          builder: (_) => RideDetailsPage(ride: ride),
        );
      case '/ride/tracker':
        return MaterialPageRoute(builder: (_) => const RideTrackerPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} non trouvée'),
            ),
          ),
        );
    }
  }
}
