import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../logging/app_logger.dart';

@singleton
class DatabaseService {
  static Database? _database;
  final AppLogger _logger;

  DatabaseService(this._logger);

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ride_univers.db');
    _logger.info('Initialisation de la base de données à : $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    _logger.info('Création des tables de la base de données');

    // Table des parcours
    await db.execute('''
      CREATE TABLE rides (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        distance REAL NOT NULL,
        duration INTEGER NOT NULL,
        date TEXT NOT NULL,
        start_location TEXT NOT NULL,
        end_location TEXT NOT NULL,
        path_coordinates TEXT NOT NULL,
        creator_id TEXT NOT NULL,
        is_synced INTEGER DEFAULT 0
      )
    ''');

    // Table des défis
    await db.execute('''
      CREATE TABLE challenges (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        objective_type TEXT NOT NULL,
        objective_value REAL NOT NULL,
        creator_id TEXT NOT NULL,
        is_synced INTEGER DEFAULT 0
      )
    ''');

    // Table des événements
    await db.execute('''
      CREATE TABLE events (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        location TEXT NOT NULL,
        type TEXT NOT NULL,
        creator_id TEXT NOT NULL,
        is_synced INTEGER DEFAULT 0
      )
    ''');

    // Table des messages
    await db.execute('''
      CREATE TABLE messages (
        id TEXT PRIMARY KEY,
        content TEXT NOT NULL,
        sender_id TEXT NOT NULL,
        receiver_id TEXT NOT NULL,
        date TEXT NOT NULL,
        is_read INTEGER DEFAULT 0,
        is_synced INTEGER DEFAULT 0
      )
    ''');

    // Table des posts
    await db.execute('''
      CREATE TABLE posts (
        id TEXT PRIMARY KEY,
        content TEXT NOT NULL,
        author_id TEXT NOT NULL,
        date TEXT NOT NULL,
        media_urls TEXT,
        likes_count INTEGER DEFAULT 0,
        comments_count INTEGER DEFAULT 0,
        is_synced INTEGER DEFAULT 0
      )
    ''');

    // Table des tournois
    await db.execute('''
      CREATE TABLE tournaments (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        rules TEXT,
        creator_id TEXT NOT NULL,
        is_synced INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    _logger.info(
        'Mise à niveau de la base de données de v$oldVersion à v$newVersion');
    // Logique de migration à implémenter selon les besoins
  }
}
