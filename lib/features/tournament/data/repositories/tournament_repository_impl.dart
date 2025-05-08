import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/tournament.dart';
import '../../domain/repositories/tournament_repository.dart';
import '../datasources/tournament_remote_data_source.dart';

@LazySingleton(as: TournamentRepository)
class TournamentRepositoryImpl implements TournamentRepository {
  final TournamentRemoteDataSource remoteDataSource;

  TournamentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Tournament>>> getTournaments() async {
    try {
      final result = await remoteDataSource.getTournaments();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Tournament>>> getMyTournaments() async {
    try {
      final result = await remoteDataSource.getMyTournaments();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tournament>> getTournamentDetails(int id) async {
    try {
      final result = await remoteDataSource.getTournamentDetails(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tournament>> createTournament({
    required String title,
    required String description,
    required DateTime date,
    required int maxParticipants,
    required double latitude,
    required double longitude,
    required String status,
    required List<String> participantIds,
  }) async {
    try {
      final result = await remoteDataSource.createTournament(
        title: title,
        description: description,
        date: date,
        maxParticipants: maxParticipants,
        latitude: latitude,
        longitude: longitude,
        status: status,
        participantIds: participantIds,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tournament>> updateTournament({
    required int id,
    String? title,
    String? description,
    DateTime? date,
    int? maxParticipants,
    double? latitude,
    double? longitude,
  }) async {
    try {
      final result = await remoteDataSource.updateTournament(
        id: id,
        title: title,
        description: description,
        date: date,
        maxParticipants: maxParticipants,
        latitude: latitude,
        longitude: longitude,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTournament(int id) async {
    try {
      await remoteDataSource.deleteTournament(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinTournament(int id) async {
    try {
      await remoteDataSource.joinTournament(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveTournament(int id) async {
    try {
      await remoteDataSource.leaveTournament(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tournament>> addTournamentVideo({
    required int id,
    required String videoUrl,
  }) async {
    try {
      final result = await remoteDataSource.addTournamentVideo(
        id: id,
        videoUrl: videoUrl,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tournament>> updateLeaderboard(
    int tournamentId,
    int userId,
    int score,
  ) async {
    try {
      final result = await remoteDataSource.updateLeaderboard(
        tournamentId,
        userId,
        score,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tournament>> completeTournament(
    int tournamentId,
    int winnerUserId,
  ) async {
    try {
      final result = await remoteDataSource.completeTournament(
        tournamentId,
        winnerUserId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tournament>> cancelTournament(int tournamentId) async {
    try {
      final result = await remoteDataSource.cancelTournament(tournamentId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Tournament>>> getActiveTournaments() async {
    try {
      final result = await remoteDataSource.getActiveTournaments();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Tournament>>> getUserTournaments(
      int userId) async {
    try {
      final result = await remoteDataSource.getUserTournaments(userId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
