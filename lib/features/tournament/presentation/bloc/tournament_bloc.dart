import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/tournament.dart';
import '../../domain/repositories/tournament_repository.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

@injectable
class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  final TournamentRepository _tournamentRepository;

  TournamentBloc(this._tournamentRepository) : super(TournamentInitial()) {
    on<LoadTournaments>(_onLoadTournaments);
    on<CreateTournament>(_onCreateTournament);
    on<UpdateTournament>(_onUpdateTournament);
    on<DeleteTournament>(_onDeleteTournament);
    on<JoinTournament>(_onJoinTournament);
    on<LeaveTournament>(_onLeaveTournament);
    on<UpdateLeaderboard>(_onUpdateLeaderboard);
    on<CompleteTournament>(_onCompleteTournament);
    on<CancelTournament>(_onCancelTournament);
    on<LoadActiveTournaments>(_onLoadActiveTournaments);
    on<LoadUserTournaments>(_onLoadUserTournaments);
  }

  Future<void> _onLoadTournaments(
      LoadTournaments event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.getTournaments();
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournaments) => emit(TournamentsLoaded(tournaments)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onCreateTournament(
      CreateTournament event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.createTournament(
        title: event.title,
        description: event.description,
        date: event.date,
        maxParticipants: event.maxParticipants ?? 0,
        latitude: event.latitude ?? 0.0,
        longitude: event.longitude ?? 0.0,
        status: 'draft',
        participantIds: const [],
      );
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournament) => emit(TournamentCreated(tournament)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onUpdateTournament(
      UpdateTournament event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.updateTournament(
        id: event.id,
        title: event.title,
        description: event.description,
        date: event.date,
        maxParticipants: event.maxParticipants ?? 0,
        latitude: event.latitude ?? 0.0,
        longitude: event.longitude ?? 0.0,
      );
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournament) => emit(TournamentUpdated(tournament)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onDeleteTournament(
      DeleteTournament event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.deleteTournament(event.id);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (_) => emit(TournamentDeleted()),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onJoinTournament(
      JoinTournament event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.joinTournament(event.id);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (_) => emit(TournamentJoined(Tournament(
          id: event.id,
          organizerId: 0,
          title: '',
          description: '',
          date: DateTime.now(),
          maxParticipants: 0,
          participantsCount: 0,
          latitude: 0,
          longitude: 0,
          isJoined: true,
          status: 'active',
          participantIds: const ['currentUserId'],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ))),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onLeaveTournament(
      LeaveTournament event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.leaveTournament(event.id);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (_) => emit(TournamentLeft(Tournament(
          id: event.id,
          organizerId: 0,
          title: '',
          description: '',
          date: DateTime.now(),
          maxParticipants: 0,
          participantsCount: 0,
          latitude: 0,
          longitude: 0,
          isJoined: false,
          status: 'active',
          participantIds: const [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ))),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onUpdateLeaderboard(
      UpdateLeaderboard event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.updateLeaderboard(
        event.tournamentId,
        event.userId,
        event.score,
      );
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournament) => emit(LeaderboardUpdated(tournament)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onCompleteTournament(
      CompleteTournament event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.completeTournament(
        event.tournamentId,
        event.winnerUserId,
      );
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournament) => emit(TournamentCompleted(tournament)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onCancelTournament(
      CancelTournament event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result =
          await _tournamentRepository.cancelTournament(event.tournamentId);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournament) => emit(TournamentCancelled(tournament)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onLoadActiveTournaments(
      LoadActiveTournaments event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result = await _tournamentRepository.getActiveTournaments();
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournaments) => emit(ActiveTournamentsLoaded(tournaments)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }

  Future<void> _onLoadUserTournaments(
      LoadUserTournaments event, Emitter<TournamentState> emit) async {
    emit(TournamentLoading());
    try {
      final result =
          await _tournamentRepository.getUserTournaments(event.userId);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournaments) => emit(UserTournamentsLoaded(tournaments)),
      );
    } catch (e) {
      emit(TournamentError(e.toString()));
    }
  }
}
