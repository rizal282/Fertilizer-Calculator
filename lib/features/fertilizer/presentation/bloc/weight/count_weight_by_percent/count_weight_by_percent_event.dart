import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/accuracy_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/deviation_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/nutrient_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/result_count_weight_fertilizer_mix_entity.dart';

abstract class CountWeightByPercentEvent {}

class SaveCountWeightByPercentEvent extends CountWeightByPercentEvent {
  final List<FertilizerEntity> fertilizerEntity;
  final NutrientTargetPercentEntity nutrientTargetPercentEntity;
  final ResultCountWeightFertilizerMixEntity
      resultCountWeightFertilizerMixEntity;

  final AccuracyTargetPercentEntity atpe;
  final DeviationTargetPercentEntity dtpe;

  SaveCountWeightByPercentEvent(
      this.fertilizerEntity,
      this.nutrientTargetPercentEntity,
      this.resultCountWeightFertilizerMixEntity,
      this.atpe,
      this.dtpe);
}

class UpdateWeightFertilizerEvent extends CountWeightByPercentEvent {
  final String idRacikan;
  final List<FertilizerEntity> fertilizerEntity;
  final NutrientTargetPercentEntity nutrientTargetPercentEntity;
  final List<ResultCountWeightFertilizerMixEntity>
      resultCountWeightFertilizerMixEntity;
  final ResultCountNutrientsAllFertilizersEntity rcnaf;

  UpdateWeightFertilizerEvent(
      {required this.fertilizerEntity,
      required this.nutrientTargetPercentEntity,
      required this.resultCountWeightFertilizerMixEntity,
      required this.rcnaf,
      required this.idRacikan});
}

class LoadCountWeightByPercentEvent extends CountWeightByPercentEvent {}

class DeleteCountWeightByPercentEvent extends CountWeightByPercentEvent {
  final String idRacikan;

  DeleteCountWeightByPercentEvent(this.idRacikan);
}
