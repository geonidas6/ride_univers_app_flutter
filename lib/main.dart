import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'core/di/injection.dart';
import 'core/routes/app_router.dart';
import 'core/config/log_config.dart';
import 'services/logger_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/ride/presentation/bloc/ride_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LogConfig.initialize();
  LoggerService.info('Application démarrée');

  // Configuration des dépendances
  await configureDependencies();

  // Attendre que SharedPreferences soit initialisé
  await GetIt.I.allReady();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetIt.I<AuthBloc>(),
            ),
            BlocProvider(
              create: (context) => GetIt.I<RideBloc>(),
            ),
          ],
          child: MaterialApp(
            title: 'Ride Univers',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: '/',
          ),
        );
      },
    );
  }
}
