import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/repositories/challenge_repository.dart';
import '../datasources/challenge_remote_datasource.dart';

@Injectable(as: ChallengeRepository)
class ChallengeRepositoryImpl implements ChallengeRepository {
  final ChallengeRemoteDataSource _remoteDataSource;
  final DatabaseService _databaseService;
  final AppLogger _logger;

  ChallengeRepositoryImpl(
    this._remoteDataSource,
    this._databaseService,
    this._logger,
  );

  @override
  Future<Either<Failure, List<Challenge>>> getChallenges() async {
    try {
      // Essayer d'abord de récupérer les données locales
      final localChallenges = await _getLocalChallenges();

      try {
        // Tenter de récupérer les données du serveur
        final remoteChallenges = await _remoteDataSource.getChallenges();

        // Mettre à jour le cache local
        await _updateLocalCache(remoteChallenges);

        return Right(remoteChallenges);
      } catch (e) {
        _logger.warning(
            'Erreur lors de la récupération des défis distants, utilisation du cache local',
            e);
        if (localChallenges.isNotEmpty) {
          return Right(localChallenges);
        }
        return Left(ServerFailure('Erreur de connexion au serveur'));
      }
    } catch (e, stackTrace) {
      _logger.error('Erreur lors de la récupération des défis', e, stackTrace);
      return Left(CacheFailure('Erreur d\'accès au cache local'));
    }
  }

  @override
  Future<Either<Failure, Challenge>> getChallengeById(String id) async {
    try {
      // Vérifier d'abord le cache local
      final db = await _databaseService.database;
      final results = await db.query(
        'challenges',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (results.isNotEmpty) {
        return Right(Challenge.fromJson(results.first));
      }

      // Si pas en cache, récupérer du serveur
      final remoteChallenge = await _remoteDataSource.getChallengeById(id);

      // Mettre en cache
      await _saveToLocalCache(remoteChallenge);

      return Right(remoteChallenge);
    } catch (e, stackTrace) {
      _logger.error(
          'Erreur lors de la récupération du défi $id', e, stackTrace);
      return Left(ServerFailure('Erreur de récupération du défi'));
    }
  }

  @override
  Future<Either<Failure, Challenge>> createChallenge(
      Challenge challenge) async {
    try {
      final newChallenge = await _remoteDataSource.createChallenge(challenge);

      // Sauvegarder en local
      await _saveToLocalCache(newChallenge);

      return Right(newChallenge);
    } catch (e, stackTrace) {
      _logger.error('Erreur lors de la création du défi', e, stackTrace);

      // Sauvegarder en local avec flag non synchronisé
      try {
        await _saveToLocalCache(challenge, isSynced: false);
        return Right(challenge);
      } catch (cacheError) {
        return Left(ServerFailure('Erreur de création du défi'));
      }
    }
  }

  Future<List<Challenge>> _getLocalChallenges() async {
    final db = await _databaseService.database;
    final results = await db.query('challenges');
    return results.map((json) => Challenge.fromJson(json)).toList();
  }

  Future<void> _updateLocalCache(List<Challenge> challenges) async {
    final db = await _databaseService.database;
    final batch = db.batch();

    // Supprimer les anciens défis synchronisés
    batch.delete(
      'challenges',
      where: 'is_synced = ?',
      whereArgs: [1],
    );

    // Insérer les nouveaux défis
    for (var challenge in challenges) {
      batch.insert(
        'challenges',
        challenge.toJson()..['is_synced'] = 1,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<void> _saveToLocalCache(Challenge challenge,
      {bool isSynced = true}) async {
    final db = await _databaseService.database;
    await db.insert(
      'challenges',
      challenge.toJson()..['is_synced'] = isSynced ? 1 : 0,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
