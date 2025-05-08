part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String passwordConfirmation;
  final String nom;
  final String prenoms;

  RegisterRequested({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.nom,
    required this.prenoms,
  });

  @override
  List<Object?> get props =>
      [email, password, passwordConfirmation, nom, prenoms];
}

class LogoutRequested extends AuthEvent {}

class UpdateProfileRequested extends AuthEvent {
  final String? nom;
  final String? prenoms;
  final String? bio;
  final String? discipline;
  final String? niveau;
  final String? ville;
  final String? avatar;

  UpdateProfileRequested({
    this.nom,
    this.prenoms,
    this.bio,
    this.discipline,
    this.niveau,
    this.ville,
    this.avatar,
  });

  @override
  List<Object?> get props =>
      [nom, prenoms, bio, discipline, niveau, ville, avatar];
}
