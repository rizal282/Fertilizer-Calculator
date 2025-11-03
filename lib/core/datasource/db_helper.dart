import 'package:path/path.dart';
import 'package:pfg_app/core/constants/string_const.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('db_fertilizer.db');

    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print('Inisialisasi database di path: $path');

    return await openDatabase(path, version: 1, onCreate: _createDb,
        onOpen: (db) {
      print('Database dibuka di path: $path');
    });
  }

  Future<void> _createDb(Database db, int version) async {
    // Create fertilizers table
    print('➡️ Membuat tabel: ${StringConst.FERTILIZERS_TABLE}');

    await db.execute('''
      CREATE TABLE ${StringConst.FERTILIZERS_TABLE} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        nama_pupuk TEXT NOT NULL,
        weight REAL,
        nitrogen REAL,
        posfor REAL,
        kalium REAL,
        boron REAL,
        tembaga REAL,
        besi REAL,
        magnesium REAL,
        mangan REAL,
        molibdenum REAL,
        seng REAL,
        kalsium REAL,
        sulfur REAL,
        created_at TEXT DEFAULT (datetime('now')),
        updated_at TEXT
      )
    ''');

    print('✅ Tabel ${StringConst.FERTILIZERS_TABLE} berhasil dibuat');

    // Create result count nutrients per fertilizer table
    print(
        '➡️ Membuat tabel: ${StringConst.RESULT_COUNT_NUTRIENTS_PER_FERTILIZER_TABLE}');

    await db.execute('''
      CREATE TABLE ${StringConst.RESULT_COUNT_NUTRIENTS_PER_FERTILIZER_TABLE} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        fertilizer_name TEXT NOT NULL,
        fertilizer_weight_grams REAL,
        total_percent_nitrogen REAL,
        total_gram_nitrogen REAL,
        total_percent_posfor REAL,
        total_gram_posfor REAL,
        total_percent_kalium REAL,
        total_gram_kalium REAL,
        total_percent_boron REAL,
        total_gram_boron REAL,
        total_percent_tembaga REAL,
        total_gram_tembaga REAL,
        total_percent_besi REAL,
        total_gram_besi REAL,
        total_percent_magnesium REAL,
        total_gram_magnesium REAL,
        total_percent_mangan REAL,
        total_gram_mangan REAL,
        total_percent_molibdenum REAL,
        total_gram_molibdenum REAL,
        total_percent_seng REAL,
        total_gram_seng REAL,
        total_percent_kalsium REAL,
        total_gram_kalsium REAL,
        total_percent_sulfur REAL,
        total_gram_sulfur REAL,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    print(
        '✅ Tabel ${StringConst.RESULT_COUNT_NUTRIENTS_PER_FERTILIZER_TABLE} berhasil dibuat');

    // Create count nutrients all mix fertilizers table
    print(
        '➡️ Membuat tabel: ${StringConst.COUNT_NUTRIENTS_ALL_FERTILIZERS_TABLE}');

    await db.execute('''
      CREATE TABLE ${StringConst.COUNT_NUTRIENTS_ALL_FERTILIZERS_TABLE} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        fertilizer_names TEXT NOT NULL,
        fertilizer_weight_grams REAL,
        total_percent_nitrogen REAL,
        total_gram_nitrogen REAL,
        total_percent_posfor REAL,
        total_gram_posfor REAL,
        total_percent_kalium REAL,
        total_gram_kalium REAL,
        total_percent_boron REAL,
        total_gram_boron REAL,
        total_percent_tembaga REAL,
        total_gram_tembaga REAL,
        total_percent_besi REAL,
        total_gram_besi REAL,
        total_percent_magnesium REAL,
        total_gram_magnesium REAL,
        total_percent_mangan REAL,
        total_gram_mangan REAL,
        total_percent_molibdenum REAL,
        total_gram_molibdenum REAL,
        total_percent_seng REAL,
        total_gram_seng REAL,
        total_percent_kalsium REAL,
        total_gram_kalsium REAL,
        total_percent_sulfur REAL,
        total_gram_sulfur REAL,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    print(
        '✅ Tabel ${StringConst.COUNT_NUTRIENTS_ALL_FERTILIZERS_TABLE} berhasil dibuat');

    print('🎉 Semua tabel berhasil dibuat');
  }

  Future close() async {
    final db = await instance.database;
    await db.close();

    print('📕 Database ditutup');
  }
}
