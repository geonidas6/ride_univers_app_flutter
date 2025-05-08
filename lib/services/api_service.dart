import 'package:dio/dio.dart';
import 'api_interceptor.dart';
import 'logger_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;
  final String baseUrl = 'https://riderbackend.sefapanel.com/api';

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Ajout de l'intercepteur pour le logging
    _dio.interceptors.add(ApiInterceptor());

    // En mode debug, ajout de l'intercepteur de logging Dio
    if (const bool.fromEnvironment('dart.vm.product') == false) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          LoggerService.debug(object.toString());
        },
      ));
    }
  }

  // Getter pour accéder à l'instance Dio
  Dio get dio => _dio;

  // Méthode pour ajouter le token d'authentification
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    LoggerService.info('Token d\'authentification mis à jour');
  }

  // Méthode pour supprimer le token d'authentification
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
    LoggerService.info('Token d\'authentification supprimé');
  }

  // Méthode utilitaire pour gérer les erreurs
  Future<T> handleError<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      LoggerService.error('Erreur API: ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      LoggerService.error('Erreur inattendue');
      rethrow;
    }
  }
}
