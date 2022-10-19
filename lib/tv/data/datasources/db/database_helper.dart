import 'package:sqflite/sqflite.dart';

import '../../models/tv_table.dart';

class TvDatabaseHelper {
  static TvDatabaseHelper? _databaseHelper;
  TvDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TvDatabaseHelper() => _databaseHelper ?? TvDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchTvList = 'watchtvlist';
  static const String _tblTvCache = 'tvcache';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchTvList (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblTvCache (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  Future<void> insertCacheTransaction(
      List<TvTable> tvList, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final tv in tvList) {
        final tvJson = tv.toJson();
        tvJson['category'] = category;
        txn.insert(_tblTvCache, tvJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTvList(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblTvCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblTvCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }
}
