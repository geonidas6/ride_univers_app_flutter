import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../services/logger_service.dart';
import '../../../../services/notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Vérifier l'état d'authentification après l'animation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        LoggerService.debug('Vérification de l\'état d\'authentification...');
        context.read<AuthBloc>().add(CheckAuthStatus());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          LoggerService.debug('État actuel: $state');
          if (state is AuthAuthenticated) {
            LoggerService.info(
                'Utilisateur authentifié, redirection vers /home');
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthUnauthenticated) {
            LoggerService.info(
                'Utilisateur non authentifié, redirection vers /login');
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is AuthError) {
            LoggerService.error('Erreur d\'authentification: ${state.message}');
            // Afficher une notification d'erreur
            NotificationService.showSnackBar(
              context: context,
              message: 'Erreur de connexion: ${state.message}',
              type: NotificationType.error,
            );
            // Rediriger vers la page de login après une erreur
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            });
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Container(
                  width: 150.w,
                  height: 150.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.directions_bike,
                      size: 80.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              FadeTransition(
                opacity: _animation,
                child: Text(
                  'Ride Univers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              FadeTransition(
                opacity: _animation,
                child: Text(
                  'Votre communauté de cyclistes',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
