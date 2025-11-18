import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/datasource/internal/db_helper.dart';
import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/data/ppm/models/ppm_solution_concentrate_model.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/entities/ppm_solution_concentration_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/repositories/ppm_repository.dart';

class PpmRepositoryImpl implements PpmRepository {
  final DbHelper _dbHelper = DbHelper.instance;

  @override
  Future<void> saveCountPpmConcentrate(
      PpmSolutionConcentrationEntity entity) async {
    final idRacikan = entity.idRacikan;
    final db = await _dbHelper.database;

    final ppmDataExist = await db.query(StringConst.ppmSolutionConcestration,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    if (ppmDataExist.isEmpty) {
      final ppmDataModel = PpmSolutionConcentrateModel.fromEntity(entity);
      await db.insert(
          StringConst.ppmSolutionConcestration, ppmDataModel.toMap());
    } else {
      Map<String, dynamic> mapPpmUpdate = {
        'total_mass_of_solute': entity.totalMassOfSolute,
        'total_ppm': entity.totalPpm,
        'total_solution_volume': entity.totalSolutionVolume,
        'updated_at': DateFormatUtil.formatDateToYYYYMMDD(DateTime.now())
      };

      await db.update(StringConst.ppmSolutionConcestration, mapPpmUpdate,
          where: 'id_racikan = ?', whereArgs: [idRacikan]);
    }
  }

  @override
  Future<List<PpmSolutionConcentrationEntity>> getCountFromPPMForm() async {
    final db = await _dbHelper.database;

    final ppmCountResult = await db.query(StringConst.ppmSolutionConcestration,
        where: 'created_at = ? AND source_ppm = ? ',
        orderBy: 'id DESC',
        whereArgs: [
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
          StringConst.sourcePpmFromCountPPMForm,
          // StringConst.countTypePPM
        ]);

    return ppmCountResult
        .map(
          (e) => PpmSolutionConcentrateModel.fromMap(e),
        )
        .toList();
  }

  @override
  Future<List<PpmSolutionConcentrationEntity>>
      getCountHasilHitungMassaZatTerlarut() async {
    final db = await _dbHelper.database;

    final hasilHitungMassaZatTerlarut = await db.query(
        StringConst.ppmSolutionConcestration,
        where: 'created_at = ? AND source_ppm = ? AND count_type = ?',
        whereArgs: [
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
          StringConst.sourcePpmFromCountPPMForm,
          StringConst.countTypeMassaZatTerlarut
        ]);

    return hasilHitungMassaZatTerlarut
        .map(
          (e) => PpmSolutionConcentrateModel.fromMap(e),
        )
        .toList();
  }

  @override
  Future<List<PpmSolutionConcentrationEntity>>
      getCountHasilHitungVolumeLarutan() async {
    final db = await _dbHelper.database;

    final hasilHitungVolumeLarutan = await db.query(
        StringConst.ppmSolutionConcestration,
        where: 'created_at = ? AND source_ppm = ? AND count_type = ?',
        whereArgs: [
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
          StringConst.sourcePpmFromCountPPMForm,
          StringConst.countTypeVolumeLarutan
        ]);

    return hasilHitungVolumeLarutan
        .map(
          (e) => PpmSolutionConcentrateModel.fromMap(e),
        )
        .toList();
  }
  
  @override
  Future<void> deletePPMCountByID(int id) async {
    final db = await _dbHelper.database;

    await db.delete(
      StringConst.ppmSolutionConcestration,
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}
