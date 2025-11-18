import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/datasource/internal/db_helper.dart';
import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/models/fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/models/result_count_nutrients_all_fertilizers_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/ppm/models/ppm_solution_concentrate_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/accuracy_target_percent_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/deviation_target_percent_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/nutrient_target_percent_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/result_count_weight_fertilizer_mix_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/response/weight_each_fertilizer_mix_response.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/accuracy_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/deviation_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/nutrient_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/result_count_weight_fertilizer_mix_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/repositories/count_weight_by_percent_target_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class CountWeightByPercentTargetRepositoryImpl
    implements CountWeightByPercentTargetRepository {
  final DbHelper dbHelper = DbHelper.instance;
  final log = Logger();

  @override
  Future<void> saveCountWeightByPercentTarget(
      List<FertilizerEntity> listFertilizerSelected,
      NutrientTargetPercentEntity nutrientTargetPercentEntity,
      ResultCountWeightFertilizerMixEntity listResultWeight,
      AccuracyTargetPercentEntity atpe,
      DeviationTargetPercentEntity dtpe) async {
    final db = await dbHelper.database;

    listFertilizerSelected.forEach(
      (element) async {
        final fertilizerModel = FertilizerModel.fromEntity(element);

        await db.insert(StringConst.fertilizersTable, fertilizerModel.toMap());
      },
    );

    final nutrientTargetPercentModel =
        NutrientTargetPercentModel.fromEntity(nutrientTargetPercentEntity);
    await db.insert(StringConst.targetNutrientsPercentTable,
        nutrientTargetPercentModel.toMap());

    final resultWeightForFertilizerMixModel =
        ResultCountWeightFertilizerMixModel.fromEntity(listResultWeight);

    await db.insert(StringConst.resultCountWeightFertilizerTable,
        resultWeightForFertilizerMixModel.toMap());

    final accuraryTargetPercentData =
        AccuracyTargetPercentModel.fromEntity(atpe);

    await db.insert(
        StringConst.accuracyTargetPercentT, accuraryTargetPercentData.toMap());

    final deviationTargetPercentData =
        DeviationTargetPercentModel.fromEntity(dtpe);

    await db.insert(
        StringConst.deviationTargetPercent, deviationTargetPercentData.toMap());
  }

  @override
  Future<List<WeightEachFertilizerMixResponse>>
      getAllCountWeightByPercentTarget() async {
    final db = await dbHelper.database;

    final User? user = FirebaseAuth.instance.currentUser;

    List<WeightEachFertilizerMixResponse> listResultWeightEachFertilizers = [];

    // get target percent
    final resultTargetPercentNutrients = await db.query(
        StringConst.targetNutrientsPercentTable,
        where: 'created_at = ? and id_user = ?',
        whereArgs: [
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
          user!.uid
        ]);

    for (var resultTargetPercentNutrient in resultTargetPercentNutrients) {
      final dataTargetPercentNutrients =
          NutrientTargetPercentModel.fromMap(resultTargetPercentNutrient);

      final idRacikan = dataTargetPercentNutrients.idRacikan;

      log.i("ID RACIKAN TARGET NUTRIENTS ===>>> $idRacikan");

      // get fertilizers inputed
      final dataFertilizersInputed = await db.query(
          StringConst.fertilizersTable,
          where: 'id_racikan = ? AND created_at = ?',
          whereArgs: [
            idRacikan,
            DateFormatUtil.formatDateToYYYYMMDD(DateTime.now())
          ]);

      final resultFertilizersInputed = dataFertilizersInputed
          .map((e) => FertilizerModel.fromMap(e))
          .toList();

      final dataResultCountWeight = await db.query(
          StringConst.resultCountWeightFertilizerTable,
          where: 'created_at = ? AND id_racikan = ?',
          whereArgs: [
            DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
            idRacikan
          ]);

      final resultWeightsEachFertilizer =
          ResultCountWeightFertilizerMixModel.fromMap(
              dataResultCountWeight.first);

      final accuracyTargetPercentData = await db.query(
          StringConst.accuracyTargetPercentT,
          where: 'created_at = ? AND id_racikan = ?',
          whereArgs: [
            DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
            idRacikan
          ]);

      final accuracyTargetPercentModel =
          AccuracyTargetPercentModel.fromMap(accuracyTargetPercentData.first);

      final deviationTargetPercentData = await db.query(
          StringConst.deviationTargetPercent,
          where: 'created_at = ? AND id_racikan = ?',
          whereArgs: [
            DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
            idRacikan
          ]);

      final deviationTargetPercentModel =
          DeviationTargetPercentModel.fromMap(deviationTargetPercentData.first);

      final ppmConcentrateData = await db.query(
          StringConst.ppmSolutionConcestration,
          where: 'id_racikan = ? AND source_ppm = ?',
          whereArgs: [idRacikan, StringConst.sourcePpmFromResultPage]);

      if (ppmConcentrateData.isNotEmpty) {
        final ppmConcentrateModel =
            PpmSolutionConcentrateModel.fromMap(ppmConcentrateData.first);

        final response = WeightEachFertilizerMixResponse(
            nutrientTargetPercentInputted: dataTargetPercentNutrients,
            fertilizersSelected: resultFertilizersInputed,
            resultCountWeightEachFertilizer: resultWeightsEachFertilizer,
            accuracyData: accuracyTargetPercentModel,
            deviationData: deviationTargetPercentModel,
            ppmSolutionConcentrate: ppmConcentrateModel);

        listResultWeightEachFertilizers.add(response);
      } else {
        final response = WeightEachFertilizerMixResponse(
            nutrientTargetPercentInputted: dataTargetPercentNutrients,
            fertilizersSelected: resultFertilizersInputed,
            resultCountWeightEachFertilizer: resultWeightsEachFertilizer,
            accuracyData: accuracyTargetPercentModel,
            deviationData: deviationTargetPercentModel,
            ppmSolutionConcentrate: PpmSolutionConcentrateModel(
                totalPpm: 0, totalMassOfSolute: 0, totalSolutionVolume: 0));

        listResultWeightEachFertilizers.add(response);
      }
    }

    return listResultWeightEachFertilizers;
  }

  @override
  Future<void> deleteFertilierWeightMixAndTargetPercent(
      String idRacikan) async {
    final db = await dbHelper.database;

    // hapus dari target persen
    await db.delete(StringConst.targetNutrientsPercentTable,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.fertilizersTable,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.resultCountWeightFertilizerTable,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.accuracyTargetPercentT,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.deviationTargetPercent,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.ppmSolutionConcestration,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);
  }

  @override
  Future<void> updateCountWeightFertilizer(
      {required String idRacikan,
      required List<FertilizerEntity> listFertilizerSelected,
      required NutrientTargetPercentEntity nutrientTargetPercentEntity,
      required List<ResultCountWeightFertilizerMixEntity> listResultWeight,
      required ResultCountNutrientsAllFertilizersEntity rcnaf}) async {
    final db = await dbHelper.database;

    await db.delete(StringConst.targetNutrientsPercentTable,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.countNutrientsAllFertilizersTable,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.fertilizersTable,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    await db.delete(StringConst.resultCountWeightFertilizerTable,
        where: 'id_racikan = ?', whereArgs: [idRacikan]);

    final targetPercentNutrientModel =
        NutrientTargetPercentModel.fromEntity(nutrientTargetPercentEntity);

    await db.insert(StringConst.targetNutrientsPercentTable,
        targetPercentNutrientModel.toMap());

    final rcnafDataModel =
        ResultCountNutrientsAllFertilizersModel.fromEntity(rcnaf);

    await db.insert(
      StringConst.countNutrientsAllFertilizersTable,
      rcnafDataModel.toMap(),
    );

    listFertilizerSelected.forEach(
      (element) async {
        final fertilizerModel = FertilizerModel.fromEntity(element);

        await db.insert(StringConst.fertilizersTable, fertilizerModel.toMap());
      },
    );

    listResultWeight.forEach(
      (element) async {
        final resultWeightForFertilizerMixModel =
            ResultCountWeightFertilizerMixModel.fromEntity(element);

        await db.insert(StringConst.resultCountWeightFertilizerTable,
            resultWeightForFertilizerMixModel.toMap());
      },
    );
  }
}
