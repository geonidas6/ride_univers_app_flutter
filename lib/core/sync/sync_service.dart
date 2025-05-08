import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:workmanager/workmanager.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database_service.dart';
import '../logging/app_logger.dart';

@singleton
class SyncService {
  final DatabaseService _databaseService;
  final AppLogger _logger;
  final Connectivity _connectivity;

  SyncService(
    this._databaseService,
    this._logger,
    this._connectivity,
  );

  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    // Planifier la synchronisation périodique
    await Workmanager().registerPeriodicTask(
      'syncData',
      'syncDataTask',
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );

    // Écouter les changements de connectivité
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        _syncData();
      }
    });
  }

  Future<void> _syncData() async {
    _logger.info('Début de la synchronisation des données');

    try {
      final db = await _databaseService.database;

      // Synchroniser les parcours
      await _syncTable(db, 'rides');

      // Synchroniser les défis
      await _syncTable(db, 'challenges');

      // Synchroniser les événements
      await _syncTable(db, 'events');

      // Synchroniser les messages
      await _syncTable(db, 'messages');

      // Synchroniser les posts
      await _syncTable(db, 'posts');

      // Synchroniser les tournois
      await _syncTable(db, 'tournaments');

      _logger.info('Synchronisation terminée avec succès');
    } catch (e, stackTrace) {
      _logger.error('Erreur lors de la synchronisation', e, stackTrace);
    }
  }

  Future<void> _syncTable(Database db, String tableName) async {
    _logger.info('Synchronisation de la table: $tableName');

    try {
      // Récupérer les enregistrements non synchronisés
      final unsyncedRecords = await db.query(
        tableName,
        where: 'is_synced = ?',
        whereArgs: [0],
      );

      for (final record in unsyncedRecords) {
        try {
          // Envoyer au serveur
          await _sendToServer(tableName, record);

          // Marquer comme synchronisé
          await db.update(
            tableName,
            {'is_synced': 1},
            where: 'id = ?',
            whereArgs: [record['id']],
          );
        } catch (e) {
          _logger.error(
            'Erreur lors de la synchronisation de l\'enregistrement ${record['id']} dans $tableName',
            e,
          );
        }
      }
    } catch (e, stackTrace) {
      _logger.error('Erreur lors de la synchronisation de la table $tableName',
          e, stackTrace);
    }
  }

  Future<void> _sendToServer(
      String tableName, Map<String, dynamic> data) async {
    // TODO: Implémenter l'envoi au serveur selon l'API
    _logger.info('Envoi des données au serveur pour $tableName: ${data['id']}');
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final syncService = SyncService(
        DatabaseService(AppLogger()),
        AppLogger(),
        Connectivity(),
      );
      await syncService._syncData();
      return true;
    } catch (e) {
      return false;
    }
  });
}
