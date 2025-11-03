import 'package:pfg_app/core/constants/string_const.dart';
import 'package:pfg_app/core/utils/date_format_util.dart';
import 'package:pfg_app/core/datasource/db_helper.dart';
import 'package:pfg_app/features/fertilizer/data/models/result_count_nutrient_per_fertilizer_model.dart';
import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrient_per_fertilizer_entity.dart';
import 'package:pfg_app/features/fertilizer/domain/repositories/rcnpf_repository.dart';

class RcnpfRepositoryImpl implements RcnpfRepository {
  final DbHelper dbHelper = DbHelper.instance;

  @override
  Future<void> insertRcnpf(
      ResultCountNutrientPerFertilizerEntity entity) async {
    final db = await dbHelper.database;

    final rcnpfModel = ResultCountNutrientPerFertilizerModel.fromEntity(entity);

    await db.insert(StringConst.RESULT_COUNT_NUTRIENTS_PER_FERTILIZER_TABLE,
        rcnpfModel.toMap());
  }

  @override
  Future<List<ResultCountNutrientPerFertilizerEntity>> getAllRcnpfsByIdRacikan(String idRacikan) async {
    final db = await dbHelper.database;

    final result = await db.query(
      StringConst.RESULT_COUNT_NUTRIENTS_PER_FERTILIZER_TABLE,
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

    await db.delete(StringConst.RESULT_COUNT_NUTRIENTS_PER_FERTILIZER_TABLE,
        where: 'created_at = ? AND id_racikan = ?', whereArgs: [dateNow, idRacikan]);
  }
}
