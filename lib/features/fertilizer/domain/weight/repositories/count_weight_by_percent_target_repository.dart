
import 'package:akurasipupuk/features/fertilizer/data/weight/response/weight_each_fertilizer_mix_response.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/accuracy_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/deviation_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/nutrient_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/result_count_weight_fertilizer_mix_entity.dart';

abstract class CountWeightByPercentTargetRepository {
  Future<void> saveCountWeightByPercentTarget(
      List<FertilizerEntity> listFertilizerSelected,
      NutrientTargetPercentEntity nutrientTargetPercentEntity,
      ResultCountWeightFertilizerMixEntity listResultWeight,
      AccuracyTargetPercentEntity atpe,
      DeviationTargetPercentEntity dtpe);

  Future<List<WeightEachFertilizerMixResponse>>
      getAllCountWeightByPercentTarget();

  Future<void> deleteFertilierWeightMixAndTargetPercent(String idRacikan);

  Future<void> updateCountWeightFertilizer(
      {required String idRacikan,
      required List<FertilizerEntity> listFertilizerSelected,
      required NutrientTargetPercentEntity nutrientTargetPercentEntity,
      required List<ResultCountWeightFertilizerMixEntity> listResultWeight,
      required ResultCountNutrientsAllFertilizersEntity rcnaf});
}
