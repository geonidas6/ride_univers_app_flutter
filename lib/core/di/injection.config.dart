// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i19;
import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i20;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i35;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i34;
import '../../features/auth/domain/usecases/check_auth_status_usecase.dart'
    as _i36;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i41;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i40;
import '../../features/auth/domain/usecases/update_profile_usecase.dart'
    as _i47;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i45;
import '../../features/challenge/data/datasources/challenge_remote_datasource.dart'
    as _i16;
import '../../features/challenge/data/repositories/challenge_repository_impl.dart'
    as _i30;
import '../../features/challenge/domain/repositories/challenge_repository.dart'
    as _i29;
import '../../features/friend/data/datasources/friend_remote_data_source.dart'
    as _i12;
import '../../features/friend/data/repositories/friend_repository_impl.dart'
    as _i22;
import '../../features/friend/domain/repositories/friend_repository.dart'
    as _i21;
import '../../features/friend/presentation/bloc/friend_bloc.dart' as _i33;
import '../../features/message/data/datasources/message_remote_data_source.dart'
    as _i11;
import '../../features/message/data/repositories/message_repository_impl.dart'
    as _i28;
import '../../features/message/domain/repositories/message_repository.dart'
    as _i27;
import '../../features/message/presentation/bloc/message_bloc.dart' as _i43;
import '../../features/post/data/datasources/post_remote_data_source.dart'
    as _i10;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i32;
import '../../features/post/domain/repositories/post_repository.dart' as _i31;
import '../../features/post/presentation/bloc/post_bloc.dart' as _i42;
import '../../features/ride/data/datasources/ride_remote_data_source.dart'
    as _i23;
import '../../features/ride/data/datasources/ride_remote_datasource.dart'
    as _i14;
import '../../features/ride/data/repositories/ride_repository_impl.dart'
    as _i26;
import '../../features/ride/domain/repositories/ride_repository.dart' as _i25;
import '../../features/ride/domain/usecases/create_ride_usecase.dart' as _i39;
import '../../features/ride/domain/usecases/get_ride_by_id_usecase.dart'
    as _i37;
import '../../features/ride/domain/usecases/get_rides_usecase.dart' as _i38;
import '../../features/ride/presentation/bloc/ride_bloc.dart' as _i44;
import '../../features/tournament/data/datasources/tournament_remote_data_source.dart'
    as _i13;
import '../../features/tournament/data/repositories/tournament_repository_impl.dart'
    as _i18;
import '../../features/tournament/domain/repositories/tournament_repository.dart'
    as _i17;
import '../../features/tournament/presentation/bloc/tournament_bloc.dart'
    as _i24;
import '../database/database_service.dart' as _i9;
import '../logging/app_logger.dart' as _i7;
import '../network_info/network_info.dart' as _i8;
import '../sync/sync_service.dart' as _i15;
import 'app_module.dart' as _i46;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.Dio>(() => appModule.dio);
  gh.singleton<_i4.Client>(() => appModule.httpClient);
  gh.singleton<_i5.Connectivity>(() => appModule.connectivity);
  await gh.singletonAsync<_i6.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.singleton<_i7.AppLogger>(() => _i7.AppLogger());
  gh.factory<_i8.NetworkInfo>(
      () => _i8.NetworkInfoImpl(gh<_i5.Connectivity>()));
  gh.singleton<_i9.DatabaseService>(
      () => _i9.DatabaseService(gh<_i7.AppLogger>()));
  gh.factory<_i10.PostRemoteDataSource>(
      () => _i10.PostRemoteDataSourceImpl(gh<_i3.Dio>()));
  gh.factory<_i11.MessageRemoteDataSource>(
      () => _i11.MessageRemoteDataSourceImpl(gh<_i3.Dio>()));
  gh.factory<_i12.FriendRemoteDataSource>(
      () => _i12.FriendRemoteDataSourceImpl(gh<_i3.Dio>()));
  gh.factory<_i13.TournamentRemoteDataSource>(
      () => _i13.TournamentRemoteDataSourceImpl(gh<_i3.Dio>()));
  gh.factory<_i14.RideRemoteDataSource>(() => _i14.RideRemoteDataSourceImpl());
  gh.singleton<_i15.SyncService>(() => _i15.SyncService(
        gh<_i9.DatabaseService>(),
        gh<_i7.AppLogger>(),
        gh<_i5.Connectivity>(),
      ));
  gh.factory<_i16.ChallengeRemoteDataSource>(
      () => _i16.ChallengeRemoteDataSourceImpl(gh<_i3.Dio>()));
  gh.lazySingleton<_i17.TournamentRepository>(() =>
      _i18.TournamentRepositoryImpl(gh<_i13.TournamentRemoteDataSource>()));
  gh.lazySingleton<_i19.AuthRemoteDataSource>(
      () => _i19.AuthRemoteDataSourceImpl(
            client: gh<_i4.Client>(),
            sharedPreferences: gh<_i6.SharedPreferences>(),
          ));
  gh.lazySingleton<_i20.AuthRemoteDataSource>(
      () => _i20.AuthRemoteDataSourceImpl(
            client: gh<_i4.Client>(),
            sharedPreferences: gh<_i6.SharedPreferences>(),
          ));
  gh.factory<_i21.FriendRepository>(
      () => _i22.FriendRepositoryImpl(gh<_i12.FriendRemoteDataSource>()));
  gh.factory<_i23.RideRemoteDataSource>(
      () => _i23.RideRemoteDataSourceImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i24.TournamentBloc>(
      () => _i24.TournamentBloc(gh<_i17.TournamentRepository>()));
  gh.lazySingleton<_i25.RideRepository>(() => _i26.RideRepositoryImpl(
        remoteDataSource: gh<_i23.RideRemoteDataSource>(),
        networkInfo: gh<_i8.NetworkInfo>(),
      ));
  gh.lazySingleton<_i27.MessageRepository>(
      () => _i28.MessageRepositoryImpl(gh<_i11.MessageRemoteDataSource>()));
  gh.factory<_i29.ChallengeRepository>(() => _i30.ChallengeRepositoryImpl(
        gh<_i16.ChallengeRemoteDataSource>(),
        gh<_i9.DatabaseService>(),
        gh<_i7.AppLogger>(),
      ));
  gh.factory<_i31.PostRepository>(
      () => _i32.PostRepositoryImpl(gh<_i10.PostRemoteDataSource>()));
  gh.factory<_i33.FriendBloc>(
      () => _i33.FriendBloc(gh<_i21.FriendRepository>()));
  gh.lazySingleton<_i34.AuthRepository>(() => _i35.AuthRepositoryImpl(
        gh<_i19.AuthRemoteDataSource>(),
        gh<_i6.SharedPreferences>(),
      ));
  gh.factory<_i36.CheckAuthStatusUseCase>(
      () => _i36.CheckAuthStatusUseCase(gh<_i34.AuthRepository>()));
  gh.factory<_i37.GetRideByIdUseCase>(
      () => _i37.GetRideByIdUseCase(gh<_i25.RideRepository>()));
  gh.factory<_i38.GetRidesUseCase>(
      () => _i38.GetRidesUseCase(gh<_i25.RideRepository>()));
  gh.factory<_i39.CreateRideUseCase>(
      () => _i39.CreateRideUseCase(gh<_i25.RideRepository>()));
  gh.factory<_i40.RegisterUseCase>(
      () => _i40.RegisterUseCase(gh<_i34.AuthRepository>()));
  gh.factory<_i41.LoginUseCase>(
      () => _i41.LoginUseCase(gh<_i34.AuthRepository>()));
  gh.factory<_i47.UpdateProfileUseCase>(
      () => _i47.UpdateProfileUseCase(gh<_i34.AuthRepository>()));
  gh.factory<_i42.PostBloc>(() => _i42.PostBloc(gh<_i31.PostRepository>()));
  gh.factory<_i43.MessageBloc>(
      () => _i43.MessageBloc(gh<_i27.MessageRepository>()));
  gh.factory<_i44.RideBloc>(() => _i44.RideBloc(
        gh<_i39.CreateRideUseCase>(),
        gh<_i38.GetRidesUseCase>(),
        gh<_i37.GetRideByIdUseCase>(),
        gh<_i25.RideRepository>(),
      ));
  gh.factory<_i45.AuthBloc>(() => _i45.AuthBloc(
        gh<_i41.LoginUseCase>(),
        gh<_i40.RegisterUseCase>(),
        gh<_i36.CheckAuthStatusUseCase>(),
        gh<_i47.UpdateProfileUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i46.AppModule {}
