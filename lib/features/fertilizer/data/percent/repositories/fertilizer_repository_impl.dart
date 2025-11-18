import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/datasource/internal/db_helper.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/models/fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/repositories/fertilizer_repository.dart';

class FertilizerRepositoryImpl implements FertilizerRepository {
  final DbHelper dbHelper = DbHelper.instance;

  @override
  Future<void> insertFertilizer(FertilizerEntity fertilizer) async {
    final db = await dbHelper.database;

    final fertilizerModel = FertilizerModel.fromEntity(fertilizer);

    await db.insert(
      StringConst.fertilizersTable,
      fertilizerModel.toMap(),
    );

    print('✅ Data pupuk "${fertilizerModel.namaPupuk}" disimpan ke DB');
  }

  @override
  Future<List<FertilizerEntity>> getAllFertilizers() async {
    final db = await dbHelper.database;
    final result = await db.query(StringConst.fertilizersTable);

    return result.map((map) => FertilizerModel.fromMap(map)).toList();
  }
  
  @override
  Future<void> deleteFertilizer(String date, String idRacikan) async {
    final db = await dbHelper.database;

    await db.delete(
      StringConst.fertilizersTable,
      where: 'created_at = ? AND id_racikan = ?',
      whereArgs: [date, idRacikan]
    );
  }

  
}
