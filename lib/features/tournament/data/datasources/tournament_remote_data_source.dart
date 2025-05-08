import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/tournament.dart';

abstract class TournamentRemoteDataSource {
  Future<List<Tournament>> getTournaments();
  Future<List<Tournament>> getMyTournaments();
  Future<Tournament> getTournamentDetails(int id);
  Future<Tournament> createTournament({
    required String title,
    required String description,
    required DateTime date,
    required int maxParticipants,
    required double latitude,
    required double longitude,
    required String status,
    required List<String> participantIds,
  });
  Future<Tournament> updateTournament({
    required int id,
    String? title,
    String? description,
    DateTime? date,
    int? maxParticipants,
    double? latitude,
    double? longitude,
  });
  Future<void> deleteTournament(int id);
  Future<void> joinTournament(int id);
  Future<void> leaveTournament(int id);
  Future<Tournament> addTournamentVideo({
    required int id,
    required String videoUrl,
  });
  Future<Tournament> updateLeaderboard(int tournamentId, int userId, int score);
  Future<Tournament> completeTournament(int tournamentId, int winnerUserId);
  Future<Tournament> cancelTournament(int tournamentId);
  Future<List<Tournament>> getActiveTournaments();
  Future<List<Tournament>> getUserTournaments(int userId);
}

@Injectable(as: TournamentRemoteDataSource)
class TournamentRemoteDataSourceImpl implements TournamentRemoteDataSource {
  final Dio dio;

  TournamentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Tournament>> getTournaments() async {
    final response = await dio.get('/tournaments');
    return (response.data['data'] as List)
        .map((json) => Tournament.fromJson(json))
        .toList();
  }

  @override
  Future<List<Tournament>> getMyTournaments() async {
    final response = await dio.get('/tournaments/me');
    return (response.data['data'] as List)
        .map((json) => Tournament.fromJson(json))
        .toList();
  }

  @override
  Future<Tournament> getTournamentDetails(int id) async {
    final response = await dio.get('/tournaments/$id');
    return Tournament.fromJson(response.data['data']);
  }

  @override
  Future<Tournament> createTournament({
    required String title,
    required String description,
    required DateTime date,
    required int maxParticipants,
    required double latitude,
    required double longitude,
    required String status,
    required List<String> participantIds,
  }) async {
    final response = await dio.post('/tournaments', data: {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'max_participants': maxParticipants,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'participant_ids': participantIds,
    });
    return Tournament.fromJson(response.data['data']);
  }

  @override
  Future<Tournament> updateTournament({
    required int id,
    String? title,
    String? description,
    DateTime? date,
    int? maxParticipants,
    double? latitude,
    double? longitude,
  }) async {
    final data = {
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (date != null) 'date': date.toIso8601String(),
      if (maxParticipants != null) 'max_participants': maxParticipants,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };

    final response = await dio.put('/tournaments/$id', data: data);
    return Tournament.fromJson(response.data['data']);
  }

  @override
  Future<void> deleteTournament(int id) async {
    await dio.delete('/tournaments/$id');
  }

  @override
  Future<void> joinTournament(int id) async {
    await dio.post('/tournaments/$id/join');
  }

  @override
  Future<void> leaveTournament(int id) async {
    await dio.delete('/tournaments/$id/join');
  }

  @override
  Future<Tournament> addTournamentVideo({
    required int id,
    required String videoUrl,
  }) async {
    final response = await dio.post('/tournaments/$id/video', data: {
      'video_url': videoUrl,
    });
    return Tournament.fromJson(response.data['data']);
  }

  @override
  Future<Tournament> updateLeaderboard(
    int tournamentId,
    int userId,
    int score,
  ) async {
    final response =
        await dio.post('/tournaments/$tournamentId/leaderboard', data: {
      'user_id': userId,
      'score': score,
    });
    return Tournament.fromJson(response.data['data']);
  }

  @override
  Future<Tournament> completeTournament(
    int tournamentId,
    int winnerUserId,
  ) async {
    final response =
        await dio.post('/tournaments/$tournamentId/complete', data: {
      'winner_user_id': winnerUserId,
    });
    return Tournament.fromJson(response.data['data']);
  }

  @override
  Future<Tournament> cancelTournament(int tournamentId) async {
    final response = await dio.post('/tournaments/$tournamentId/cancel');
    return Tournament.fromJson(response.data['data']);
  }

  @override
  Future<List<Tournament>> getActiveTournaments() async {
    final response = await dio.get('/tournaments/active');
    return (response.data['data'] as List)
        .map((json) => Tournament.fromJson(json))
        .toList();
  }

  @override
  Future<List<Tournament>> getUserTournaments(int userId) async {
    final response = await dio.get('/tournaments/user/$userId');
    return (response.data['data'] as List)
        .map((json) => Tournament.fromJson(json))
        .toList();
  }
}
