import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Pas de connexion internet');
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure(String message, [this.errors]) : super(message);

  @override
  List<Object> get props => [message, if (errors != null) errors!];
}
