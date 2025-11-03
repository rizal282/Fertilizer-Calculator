import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrient_per_fertilizer_entity.dart';

double countNutrientGrams(double totalAllWeightFertilizers, List<ResultCountNutrientPerFertilizerEntity> rcnpfList, String totalNutrientGramName) {
  final totalNutrientGrams =  rcnpfList.fold<double>(
            0.0, (sum, item) => sum + item[totalNutrientGramName]) /
        totalAllWeightFertilizers *
        100;


  return double.parse(totalNutrientGrams.toStringAsFixed(2));
}

