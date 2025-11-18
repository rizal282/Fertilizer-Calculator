import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrient_per_fertilizer_entity.dart';

double countNutrientPercents(
    double totalAllWeightFertilizers,
    List<ResultCountNutrientPerFertilizerEntity> rcnpfList,
    String totalNutrientPercentName) {
      
  final totalNutrientPercents = rcnpfList.fold<double>(
          0.0, (sum, item) => sum + item[totalNutrientPercentName]) /
      totalAllWeightFertilizers *
      100;

  return double.parse(totalNutrientPercents.toStringAsFixed(3));
}
