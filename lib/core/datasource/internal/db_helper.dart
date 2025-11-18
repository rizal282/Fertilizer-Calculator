import 'package:akurasipupuk/core/constants/string_query.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  var log = Logger();

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('db_fertilizer.db');

    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    log.i('Inisialisasi database di path: $path');

    return await openDatabase(path, version: 1, onCreate: _createDb,
        onOpen: (db) {
      log.i('Database dibuka di path: $path');
    });
  }

  Future<void> _createDb(Database db, int version) async {

    // table user

    // await db.execute(StringQuery.queryCreateTableUser);

    await db.execute(StringQuery.queryFertilizersTable);

    await db.execute(StringQuery.queryResultCountNutrientsPerFertilizerTable);

    await db.execute(StringQuery.queryCountNutrientsAllFertilizersTable);

    await db.execute(StringQuery.queryTargetNutrientsPercentTable);

    await db.execute(StringQuery.queryResultCountWeightFertilizerTable);

    await db.execute(StringQuery.queryAccuracyTargetPercent);

    await db.execute(StringQuery.queryDeviationTargetPercent);

    await db.execute(StringQuery.queryPpmSolutionConcentration);

    log.i('🎉 Semua tabel berhasil dibuat');
  }

  Future close() async {
    final db = await instance.database;
    await db.close();

    log.i('📕 Database ditutup');
  }
}
