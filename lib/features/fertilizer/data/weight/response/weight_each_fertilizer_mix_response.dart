import 'package:akurasipupuk/features/fertilizer/data/percent/models/fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/ppm/models/ppm_solution_concentrate_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/accuracy_target_percent_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/deviation_target_percent_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/nutrient_target_percent_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/result_count_weight_fertilizer_mix_model.dart';

class WeightEachFertilizerMixResponse {
  final NutrientTargetPercentModel nutrientTargetPercentInputted;
  final List<FertilizerModel> fertilizersSelected;
  final ResultCountWeightFertilizerMixModel
      resultCountWeightEachFertilizer;

  final PpmSolutionConcentrateModel ppmSolutionConcentrate;
  final AccuracyTargetPercentModel accuracyData;
  final DeviationTargetPercentModel deviationData;

  const WeightEachFertilizerMixResponse({
    required this.nutrientTargetPercentInputted,
    required this.fertilizersSelected,
    required this.resultCountWeightEachFertilizer,
    required this.ppmSolutionConcentrate,
    required this.accuracyData,
    required this.deviationData,
  });

  double countTotalFertilizerMixGrams() {
    double totalGrams = 0;

    for (var element in fertilizersSelected) {
      totalGrams += element.weight;
    }

    return totalGrams;
  }

}
