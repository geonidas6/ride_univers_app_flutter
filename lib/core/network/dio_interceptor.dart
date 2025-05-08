import 'package:dio/dio.dart';
import '../config/log_config.dart';
import '../../services/logger_service.dart';
import '../../services/notification_service.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (LogConfig.showInfoLogs) {
      LoggerService.info(
          '🌐 REQUEST[${options.method}] => PATH: ${options.uri}');

      if (LogConfig.showDebugLogs) {
        LoggerService.debug('Headers: ${options.headers}');
        LoggerService.debug('Data: ${options.data}');
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (LogConfig.showInfoLogs) {
      LoggerService.info(
        '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}',
      );

      if (LogConfig.showDebugLogs) {
        LoggerService.debug('Data: ${response.data}');
      }
    }

    if (response.statusCode == 200) {
      if (response.data['message'] != null) {
        NotificationService.showSuccess(response.data['message']);
      }
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (LogConfig.showInfoLogs) {
      LoggerService.error(
        '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}',
        error: err,
        stackTrace: LogConfig.showStackTrace ? err.stackTrace : null,
      );
      LoggerService.debug('qsq: ${LogConfig.showInfoLogs}');
      if (LogConfig.showDebugLogs) {
        LoggerService.debug('Response: ${err.response?.data}');
        //si data?message existe afficher une dialogue contenant le message

        if (err.response?.data['message'] != null) {
          NotificationService.showError(err.response?.data['message']);
        }
      }
    }

    String errorMessage = 'Une erreur est survenue';
    if (err.response?.data != null) {
      if (err.response?.data['message'] != null) {
        errorMessage = err.response?.data['message'];
      } else if (err.response?.data['errors'] != null) {
        // Gérer les erreurs de validation
        final errors = err.response?.data['errors'] as Map<String, dynamic>;
        errorMessage = errors.values.first[0].toString();
      }
    }
    NotificationService.showError(errorMessage);

    return super.onError(err, handler);
  }
}
