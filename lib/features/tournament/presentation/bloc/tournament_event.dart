part of 'tournament_bloc.dart';

abstract class TournamentEvent extends Equatable {
  const TournamentEvent();

  @override
  List<Object?> get props => [];
}

class LoadTournaments extends TournamentEvent {}

class CreateTournament extends TournamentEvent {
  final String title;
  final String description;
  final DateTime date;
  final int maxParticipants;
  final double latitude;
  final double longitude;

  const CreateTournament({
    required this.title,
    required this.description,
    required this.date,
    required this.maxParticipants,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        date,
        maxParticipants,
        latitude,
        longitude,
      ];
}

class UpdateTournament extends TournamentEvent {
  final int id;
  final String? title;
  final String? description;
  final DateTime? date;
  final int? maxParticipants;
  final double? latitude;
  final double? longitude;

  const UpdateTournament({
    required this.id,
    this.title,
    this.description,
    this.date,
    this.maxParticipants,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        maxParticipants,
        latitude,
        longitude,
      ];
}

class DeleteTournament extends TournamentEvent {
  final int id;

  const DeleteTournament(this.id);

  @override
  List<Object?> get props => [id];
}

class JoinTournament extends TournamentEvent {
  final int id;

  const JoinTournament(this.id);

  @override
  List<Object?> get props => [id];
}

class LeaveTournament extends TournamentEvent {
  final int id;

  const LeaveTournament(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateLeaderboard extends TournamentEvent {
  final int tournamentId;
  final int userId;
  final int score;

  const UpdateLeaderboard({
    required this.tournamentId,
    required this.userId,
    required this.score,
  });

  @override
  List<Object?> get props => [tournamentId, userId, score];
}

class CompleteTournament extends TournamentEvent {
  final int tournamentId;
  final int winnerUserId;

  const CompleteTournament({
    required this.tournamentId,
    required this.winnerUserId,
  });

  @override
  List<Object?> get props => [tournamentId, winnerUserId];
}

class CancelTournament extends TournamentEvent {
  final int tournamentId;

  const CancelTournament(this.tournamentId);

  @override
  List<Object?> get props => [tournamentId];
}

class LoadActiveTournaments extends TournamentEvent {}

class LoadUserTournaments extends TournamentEvent {
  final int userId;

  const LoadUserTournaments(this.userId);

  @override
  List<Object?> get props => [userId];
}
