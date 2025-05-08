import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../data/models/user_model.dart';
import '../../data/models/user_profile_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  AuthBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._checkAuthStatusUseCase,
    this._updateProfileUseCase,
  ) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);

    // Vérifier l'état d'authentification au démarrage
    add(CheckAuthStatus());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _checkAuthStatusUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(user != null
          ? AuthAuthenticated(UserProfileModel(
              id: user.id,
              email: user.email,
              nom: user.nom,
              prenoms: user.prenoms,
              avatar: user.avatar,
              bio: user.bio,
              friends: user.friends,
              friendRequests: user.friendRequests,
              blockedUsers: user.blockedUsers,
              createdAt: user.createdAt,
              updatedAt: user.updatedAt,
              discipline: null,
              niveau: null,
              ville: null,
              totalDistance: 0.0,
              batteryLevel: 100,
              darkMode: false,
              settings: null,
            ))
          : AuthUnauthenticated()),
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _loginUseCase(
        email: event.email,
        password: event.password,
      );
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(UserProfileModel(
          id: user.id,
          email: user.email,
          nom: user.nom,
          prenoms: user.prenoms,
          avatar: user.avatar,
          bio: user.bio,
          friends: user.friends,
          friendRequests: user.friendRequests,
          blockedUsers: user.blockedUsers,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
          discipline: null,
          niveau: null,
          ville: null,
          totalDistance: 0.0,
          batteryLevel: 100,
          darkMode: false,
          settings: null,
        ))),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _registerUseCase(
        email: event.email,
        password: event.password,
        nom: event.nom,
        prenoms: event.prenoms,
        passwordConfirmation: event.passwordConfirmation,
      );
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(UserProfileModel(
          id: user.id,
          email: user.email,
          nom: user.nom,
          prenoms: user.prenoms,
          avatar: user.avatar,
          bio: user.bio,
          friends: user.friends,
          friendRequests: user.friendRequests,
          blockedUsers: user.blockedUsers,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
          discipline: null,
          niveau: null,
          ville: null,
          totalDistance: 0.0,
          batteryLevel: 100,
          darkMode: false,
          settings: null,
        ))),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInitial());
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _updateProfileUseCase(
        nom: event.nom,
        prenoms: event.prenoms,
        bio: event.bio,
        avatar: event.avatar,
        discipline: event.discipline,
        niveau: event.niveau,
        ville: event.ville,
      );

      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) {
          // Si l'état actuel est AuthAuthenticated, créer un nouvel état avec les nouvelles valeurs
          if (state is AuthAuthenticated) {
            final currentUser = (state as AuthAuthenticated).user;

            // Créer un UserProfileModel mis à jour avec les nouvelles valeurs
            final updatedUser = UserProfileModel(
              id: currentUser.id,
              email: currentUser.email,
              nom: event.nom ?? currentUser.nom,
              prenoms: event.prenoms ?? currentUser.prenoms,
              avatar: event.avatar ?? currentUser.avatar,
              bio: event.bio ?? currentUser.bio,
              friends: currentUser.friends,
              friendRequests: currentUser.friendRequests,
              blockedUsers: currentUser.blockedUsers,
              createdAt: currentUser.createdAt,
              updatedAt: DateTime.now(),

              // Gérer les propriétés spécifiques au UserProfile
              discipline: event.discipline ??
                  (currentUser is UserProfile ? currentUser.discipline : null),
              niveau: event.niveau ??
                  (currentUser is UserProfile ? currentUser.niveau : null),
              ville: event.ville ??
                  (currentUser is UserProfile ? currentUser.ville : null),
              totalDistance:
                  currentUser is UserProfile ? currentUser.totalDistance : 0.0,
              batteryLevel:
                  currentUser is UserProfile ? currentUser.batteryLevel : 100,
              darkMode:
                  currentUser is UserProfile ? currentUser.darkMode : false,
              settings:
                  currentUser is UserProfile ? currentUser.settings : null,
            );

            emit(AuthAuthenticated(updatedUser));
          } else {
            // Rechargeons les données utilisateur dans le cas où nous ne sommes pas déjà authentifiés
            add(CheckAuthStatus());
          }
        },
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
