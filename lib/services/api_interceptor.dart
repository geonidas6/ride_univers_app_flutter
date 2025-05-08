import 'package:dio/dio.dart';
import '../core/error/laravel_exception.dart';
import 'logger_service.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final baseUrl = options.baseUrl;
    final path = options.path;
    LoggerService.info(
        '[INFO] 🌐 REQUEST[${options.method}] => $baseUrl/$path');
    LoggerService.debug('Request Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final baseUrl = response.requestOptions.baseUrl;
    final path = response.requestOptions.path;
    LoggerService.info(
        '[INFO] ✅ RESPONSE[${response.statusCode}] => $baseUrl/$path');
    LoggerService.debug('Response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode ?? 0;
    final baseUrl = err.requestOptions.baseUrl;
    final path = err.requestOptions.path;
    final errorType = err.type.toString().split('.').last;

    try {
      // Gestion spécifique des erreurs de validation (422)
      if (statusCode == 422 && err.response?.data != null) {
        try {
          final exception = LaravelException.fromJson(
              err.response?.data as Map<String, dynamic>);
          final errorMessages = <String>[];

          exception.errors.forEach((field, errors) {
            errorMessages.addAll(errors.map((e) => '• $field: $e'));
          });

          LoggerService.error(
              '[ERROR] ❌ VALIDATION[$statusCode] => $baseUrl/$path\n${errorMessages.join('\n')}\nError: ${exception.message}');
        } catch (validationError) {
          // Si le parsing de l'erreur de validation échoue
          LoggerService.error(
              '[ERROR] ❌ VALIDATION_PARSE_ERROR[$statusCode] => $baseUrl/$path\nError: ${err.response?.data}');
        }
      }
      // Gestion des erreurs réseau (pas de réponse du serveur)
      else if (err.response == null) {
        LoggerService.error(
            '[ERROR] 🔌 NETWORK[$errorType] => $baseUrl/$path\nError: ${err.message}');
      }
      // Autres erreurs avec réponse du serveur
      else {
        try {
          final exception = LaravelException.fromJson(
              err.response?.data as Map<String, dynamic>);
          LoggerService.error(
              '[ERROR] ❌ SERVER[$statusCode][$errorType] => $baseUrl/$path\n${exception.message}\nErrors: ${exception.errors}');
        } catch (e) {
          // Fallback pour les erreurs non-Laravel
          LoggerService.error(
              '[ERROR] ❌ UNKNOWN[$statusCode][$errorType] => $baseUrl/$path\nError: ${err.response?.data ?? err.message}');
        }
      }
    } catch (e) {
      // Fallback ultime en cas d'erreur dans le traitement des erreurs
      LoggerService.error(
          '[ERROR] 💥 CRITICAL => $baseUrl/$path\nError: ${e.toString()}');
    }

    // Toujours logger les données de debug
    if (err.response?.data != null) {
      LoggerService.debug('Response Data: ${err.response?.data}');
    }
    if (err.requestOptions.data != null) {
      LoggerService.debug('Request Data: ${err.requestOptions.data}');
    }

    super.onError(err, handler);
  }
}
