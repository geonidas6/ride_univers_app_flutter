part of 'tournament_bloc.dart';

abstract class TournamentState extends Equatable {
  const TournamentState();

  @override
  List<Object?> get props => [];
}

class TournamentInitial extends TournamentState {}

class TournamentLoading extends TournamentState {}

class TournamentsLoaded extends TournamentState {
  final List<Tournament> tournaments;

  const TournamentsLoaded(this.tournaments);

  @override
  List<Object?> get props => [tournaments];
}

class TournamentCreated extends TournamentState {
  final Tournament tournament;

  const TournamentCreated(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class TournamentUpdated extends TournamentState {
  final Tournament tournament;

  const TournamentUpdated(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class TournamentDeleted extends TournamentState {}

class TournamentJoined extends TournamentState {
  final Tournament tournament;

  const TournamentJoined(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class TournamentLeft extends TournamentState {
  final Tournament tournament;

  const TournamentLeft(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class LeaderboardUpdated extends TournamentState {
  final Tournament tournament;

  const LeaderboardUpdated(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class TournamentCompleted extends TournamentState {
  final Tournament tournament;

  const TournamentCompleted(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class TournamentCancelled extends TournamentState {
  final Tournament tournament;

  const TournamentCancelled(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class ActiveTournamentsLoaded extends TournamentState {
  final List<Tournament> tournaments;

  const ActiveTournamentsLoaded(this.tournaments);

  @override
  List<Object?> get props => [tournaments];
}

class UserTournamentsLoaded extends TournamentState {
  final List<Tournament> tournaments;

  const UserTournamentsLoaded(this.tournaments);

  @override
  List<Object?> get props => [tournaments];
}

class TournamentError extends TournamentState {
  final String message;

  const TournamentError(this.message);

  @override
  List<Object?> get props => [message];
}
