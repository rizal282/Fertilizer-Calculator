
import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/datasource/internal/db_helper.dart';
import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/models/result_count_nutrients_all_fertilizers_model.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/repositories/rcnaf_repository.dart';

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
        StringConst.countNutrientsAllFertilizersTable, rcnafModel.toMap());
  }

  @override
  Future<List<ResultCountNutrientsAllFertilizersEntity>> getAllRcnafs() async {
    final db = await dbHelper.database;

    final result = await db.query(
      StringConst.countNutrientsAllFertilizersTable,
      where: 'created_at = ? AND count_type = ?',
      whereArgs: [DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()), StringConst.countTypePercent],
      orderBy: 'id DESC'
    );

    return result
        .map((map) => ResultCountNutrientsAllFertilizersModel.fromMap(map))
        .toList();
  }

  @override
  Future<void> deleteRcnaf(String date, String idRacikan) async {
    final db = await dbHelper.database;

    await db.delete(StringConst.countNutrientsAllFertilizersTable,
        where: 'created_at = ? AND id_racikan = ? AND count_type = ?', 
        whereArgs: [date, idRacikan, StringConst.countTypePercent]
      );
  }
}
