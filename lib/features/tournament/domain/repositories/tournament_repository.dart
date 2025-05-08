import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/tournament.dart';

abstract class TournamentRepository {
  Future<Either<Failure, List<Tournament>>> getTournaments();
  Future<Either<Failure, List<Tournament>>> getMyTournaments();
  Future<Either<Failure, Tournament>> getTournamentDetails(int id);
  Future<Either<Failure, Tournament>> createTournament({
    required String title,
    required String description,
    required DateTime date,
    required int maxParticipants,
    required double latitude,
    required double longitude,
    required String status,
    required List<String> participantIds,
  });
  Future<Either<Failure, Tournament>> updateTournament({
    required int id,
    String? title,
    String? description,
    DateTime? date,
    required int maxParticipants,
    required double latitude,
    required double longitude,
  });
  Future<Either<Failure, void>> deleteTournament(int id);
  Future<Either<Failure, void>> joinTournament(int id);
  Future<Either<Failure, void>> leaveTournament(int id);
  Future<Either<Failure, Tournament>> addTournamentVideo({
    required int id,
    required String videoUrl,
  });
  Future<Either<Failure, Tournament>> updateLeaderboard(
      int tournamentId, int userId, int score);
  Future<Either<Failure, Tournament>> completeTournament(
      int tournamentId, int winnerUserId);
  Future<Either<Failure, Tournament>> cancelTournament(int tournamentId);
  Future<Either<Failure, List<Tournament>>> getActiveTournaments();
  Future<Either<Failure, List<Tournament>>> getUserTournaments(int userId);
}
