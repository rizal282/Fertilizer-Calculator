import 'package:pfg_app/core/constants/string_const.dart';
import 'package:pfg_app/core/datasource/db_helper.dart';
import 'package:pfg_app/core/utils/date_format_util.dart';
import 'package:pfg_app/features/fertilizer/data/models/result_count_nutrients_all_fertilizers_model.dart';
import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:pfg_app/features/fertilizer/domain/repositories/rcnaf_repository.dart';

class RcnafRepositoryImpl implements RcnafRepository {
  final DbHelper dbHelper = DbHelper.instance;

  @override
  Future<void> insertRcnaf(
      ResultCountNutrientsAllFertilizersEntity rcnafEntity) async {
    final db = await dbHelper.database;

    // Convert entity to map or model as needed
    final rcnafModel =
        ResultCountNutrientsAllFertilizersModel.fromEntity(rcnafEntity);

    await db.insert(
        StringConst.COUNT_NUTRIENTS_ALL_FERTILIZERS_TABLE, rcnafModel.toMap());
  }

  @override
  Future<List<ResultCountNutrientsAllFertilizersEntity>> getAllRcnafs() async {
    final db = await dbHelper.database;

    final result = await db.query(
      StringConst.COUNT_NUTRIENTS_ALL_FERTILIZERS_TABLE,
      where: 'created_at = ?',
      whereArgs: [DateFormatUtil.formatDateToYYYYMMDD(DateTime.now())],
      orderBy: 'id DESC'
    );

    return result
        .map((map) => ResultCountNutrientsAllFertilizersModel.fromMap(map))
        .toList();
  }

  @override
  Future<void> deleteRcnaf(String date, String idRacikan) async {
    final db = await dbHelper.database;

    await db.delete(StringConst.COUNT_NUTRIENTS_ALL_FERTILIZERS_TABLE,
        where: 'created_at = ? AND id_racikan = ?', 
        whereArgs: [date, idRacikan]
      );
  }
}
