import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/datasource/internal/db_helper.dart';
import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/models/result_count_nutrient_per_fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrient_per_fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/repositories/rcnpf_repository.dart';

class RcnpfRepositoryImpl implements RcnpfRepository {
  final DbHelper dbHelper = DbHelper.instance;

  @override
  Future<void> insertRcnpf(
      ResultCountNutrientPerFertilizerEntity entity) async {
    final db = await dbHelper.database;

    final rcnpfModel = ResultCountNutrientPerFertilizerModel.fromEntity(entity);

    await db.insert(StringConst.resultCountNutrientsPerFertilizerTable,
        rcnpfModel.toMap());
  }

  @override
  Future<List<ResultCountNutrientPerFertilizerEntity>> getAllRcnpfsByIdRacikan(String idRacikan) async {
    final db = await dbHelper.database;

    final result = await db.query(
      StringConst.resultCountNutrientsPerFertilizerTable,
      where: 'created_at = ? AND id_racikan = ?',
      whereArgs: [DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()), idRacikan],
    );

    return result
        .map((map) => ResultCountNutrientPerFertilizerModel.fromMap(map))
        .toList();
  }

  @override
  Future<void> deleteRcnpf(String dateNow, String idRacikan) async {
    final db = await dbHelper.database;

    await db.delete(StringConst.resultCountNutrientsPerFertilizerTable,
        where: 'created_at = ? AND id_racikan = ?', whereArgs: [dateNow, idRacikan]);
  }
}
