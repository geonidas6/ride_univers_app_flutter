class LaravelException implements Exception {
  final String message;
  final Map<String, List<String>> errors;
  final int? statusCode;

  LaravelException({
    required this.message,
    required this.errors,
    this.statusCode,
  });

  factory LaravelException.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LaravelException(
        message: 'Erreur inconnue',
        errors: {},
      );
    }

    final message = json['message'] as String? ?? 'Erreur inconnue';
    final errors = <String, List<String>>{};

    if (json['errors'] != null && json['errors'] is Map) {
      final errorMap = json['errors'] as Map<String, dynamic>;
      errorMap.forEach((key, value) {
        if (value is List) {
          errors[key] = value.map((e) => e.toString()).toList();
        } else {
          errors[key] = [value.toString()];
        }
      });
    }

    return LaravelException(
      message: message,
      errors: errors,
      statusCode: json['status_code'] as int?,
    );
  }

  bool get hasErrors => errors.isNotEmpty;

  List<String> getFieldErrors(String field) {
    return errors[field] ?? [];
  }

  String get firstError {
    if (!hasErrors) return message;
    final firstField = errors.entries.first;
    return firstField.value.first;
  }

  @override
  String toString() {
    if (!hasErrors) return message;

    final buffer = StringBuffer(message);
    buffer.writeln();
    errors.forEach((field, messages) {
      messages.forEach((msg) {
        buffer.writeln('$field: $msg');
      });
    });
    return buffer.toString();
  }
}
