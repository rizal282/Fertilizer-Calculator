import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrient_per_fertilizer_entity.dart';

double countNutrientGrams(double totalAllWeightFertilizers, List<ResultCountNutrientPerFertilizerEntity> rcnpfList, String totalNutrientGramName) {
  // final totalNutrientGrams =  rcnpfList.fold<double>(
  //           0.0, (sum, item) => sum + item[totalNutrientGramName]) /
  //       totalAllWeightFertilizers *
  //       100;

  final totalNutrientGrams =  rcnpfList.fold<double>(
            0.0, (sum, item) => sum + item[totalNutrientGramName]);


  return double.parse(totalNutrientGrams.toStringAsFixed(3));
}

