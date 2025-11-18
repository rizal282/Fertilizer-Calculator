import 'package:akurasipupuk/core/constants/string_const.dart';

class StringQuery {
  static const String queryCreateTableUser = '''
      CREATE TABLE ${StringConst.usersTable} (
        id_user TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        fullname TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT
      )
  ''';

  static const String queryDeviationTargetPercent = '''
      CREATE TABLE ${StringConst.deviationTargetPercent} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        nitrogen_percent REAL,
        posfor_percent REAL,
        kalium_percent REAL,
        boron_percent REAL,
        tembaga_percent REAL,
        besi_percent REAL,
        magnesium_percent REAL,
        mangan_percent REAL,
        molibdenum_percent REAL,
        seng_percent REAL,
        kalsium_percent REAL,
        sulfur_percent REAL,
        created_at TEXT DEFAULT (datetime('now')),
        updated_at TEXT
      )
    ''';

  static const String queryAccuracyTargetPercent = '''
      CREATE TABLE ${StringConst.accuracyTargetPercentT} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        nitrogen_percent REAL,
        posfor_percent REAL,
        kalium_percent REAL,
        boron_percent REAL,
        tembaga_percent REAL,
        besi_percent REAL,
        magnesium_percent REAL,
        mangan_percent REAL,
        molibdenum_percent REAL,
        seng_percent REAL,
        kalsium_percent REAL,
        sulfur_percent REAL,
        created_at TEXT DEFAULT (datetime('now')),
        updated_at TEXT
      )
    ''';

  static const String queryResultCountWeightFertilizerTable = '''
      CREATE TABLE ${StringConst.resultCountWeightFertilizerTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        nitrogen_percent REAL,
        posfor_percent REAL,
        kalium_percent REAL,
        boron_percent REAL,
        tembaga_percent REAL,
        besi_percent REAL,
        magnesium_percent REAL,
        mangan_percent REAL,
        molibdenum_percent REAL,
        seng_percent REAL,
        kalsium_percent REAL,
        sulfur_percent REAL,
        created_at TEXT DEFAULT (datetime('now')),
        updated_at TEXT
      )
    ''';

  static const String queryTargetNutrientsPercentTable = '''
      CREATE TABLE ${StringConst.targetNutrientsPercentTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_user TEXT NOT NULL,
        id_racikan TEXT NOT NULL,
        weight_target REAL,
        nitrogen_percent REAL,
        posfor_percent REAL,
        kalium_percent REAL,
        boron_percent REAL,
        tembaga_percent REAL,
        besi_percent REAL,
        magnesium_percent REAL,
        mangan_percent REAL,
        molibdenum_percent REAL,
        seng_percent REAL,
        kalsium_percent REAL,
        sulfur_percent REAL,
        created_at TEXT DEFAULT (datetime('now')),
        updated_at TEXT
      )
    ''';

  static const String queryCountNutrientsAllFertilizersTable = '''
      CREATE TABLE ${StringConst.countNutrientsAllFertilizersTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        id_user TEXT NOT NULL,
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
        count_type TEXT,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''';

  static const String queryResultCountNutrientsPerFertilizerTable = '''
      CREATE TABLE ${StringConst.resultCountNutrientsPerFertilizerTable} (
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
    ''';

  static const String queryFertilizersTable = '''
      CREATE TABLE ${StringConst.fertilizersTable} (
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
    ''';

  static const String queryPpmSolutionConcentration = '''
      CREATE TABLE ${StringConst.ppmSolutionConcestration} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_racikan TEXT NOT NULL,
        total_ppm REAL,
        total_mass_of_solute REAL,
        total_solution_volume REAL,
        source_ppm TEXT,
        count_type TEXT,
        created_at TEXT DEFAULT (datetime('now')),
        updated_at TEXT
      )
    ''';
}
