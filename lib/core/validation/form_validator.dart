import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import '../../services/notification_service.dart';

class FormValidator {
  static Either<Failure, String> validatePassword(String password) {
    if (password.isEmpty) {
      const message = 'Le champ mot de passe est requis';
      NotificationService.showError(message);
      return Left(ValidationFailure(message));
    }

    if (password.length < 8) {
      const message = 'Le mot de passe doit contenir au moins 8 caractères';
      NotificationService.showError(message);
      return Left(ValidationFailure(message));
    }

    return Right(password);
  }

  static Either<Failure, String> validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      const message = 'Le champ email est requis';
      NotificationService.showError(message);
      return Left(ValidationFailure(message));
    }

    if (!emailRegex.hasMatch(email)) {
      const message = 'Veuillez entrer une adresse email valide';
      NotificationService.showError(message);
      return Left(ValidationFailure(message));
    }

    return Right(email);
  }

  static void handleApiValidationErrors(Map<String, dynamic>? errors) {
    if (errors == null) return;

    try {
      errors.forEach((field, errorList) {
        if (errorList is List && errorList.isNotEmpty) {
          NotificationService.showError(errorList.first.toString());
        }
      });
    } catch (e) {
      NotificationService.showError('Une erreur de validation est survenue');
    }
  }
}
