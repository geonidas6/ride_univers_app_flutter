import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@module
abstract class AppModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  http.Client get httpClient => http.Client();

  @singleton
  Connectivity get connectivity => Connectivity();

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
