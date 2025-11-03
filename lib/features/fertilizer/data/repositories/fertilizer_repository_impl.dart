import 'package:pfg_app/core/constants/string_const.dart';
import 'package:pfg_app/core/datasource/db_helper.dart';
import 'package:pfg_app/features/fertilizer/data/models/fertilizer_model.dart';
import 'package:pfg_app/features/fertilizer/domain/entities/fertilizer_entity.dart';
import 'package:pfg_app/features/fertilizer/domain/repositories/fertilizer_repository.dart';

class FertilizerRepositoryImpl implements FertilizerRepository {
  final DbHelper dbHelper = DbHelper.instance;

  @override
  Future<void> insertFertilizer(FertilizerEntity fertilizer) async {
    final db = await dbHelper.database;

    final fertilizerModel = FertilizerModel.fromEntity(fertilizer);

    await db.insert(
      StringConst.FERTILIZERS_TABLE,
      fertilizerModel.toMap(),
    );

    print('✅ Data pupuk "${fertilizerModel.namaPupuk}" disimpan ke DB');
  }

  @override
  Future<List<FertilizerEntity>> getAllFertilizers() async {
    final db = await dbHelper.database;
    final result = await db.query(StringConst.FERTILIZERS_TABLE);

    return result.map((map) => FertilizerModel.fromMap(map)).toList();
  }
  
  @override
  Future<void> deleteFertilizer(String date, String idRacikan) async {
    final db = await dbHelper.database;

    await db.delete(
      StringConst.FERTILIZERS_TABLE,
      where: 'created_at = ? AND id_racikan = ?',
      whereArgs: [date, idRacikan]
    );
  }

  
}
