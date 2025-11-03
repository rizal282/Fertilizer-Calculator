import 'package:pfg_app/features/fertilizer/presentation/model/fertilizer_input.dart';

final double _fertilizerPerKg = 1000.0;

double countNutrientPercent(
    String keyNutrientName, FertilizerInput fertilizer) {
  final fertilizerName = fertilizer.namaPupukController.text;

  final weightInGrams =
      double.tryParse(fertilizer.weightController.text) ?? 0.0;

  final nutrient = fertilizer.nutrients[keyNutrientName]!.text;

  if (nutrient.isNotEmpty) {
    final concentration = double.tryParse(nutrient) ?? 0.0;

    final resultInPercent = (concentration / _fertilizerPerKg) * weightInGrams;

    print('Total $keyNutrientName: $resultInPercent % in $fertilizerName');

    return double.parse(resultInPercent.toStringAsFixed(2));
  }

  return 0.0;
}

double countNutrientGram(String keyNutrientName, FertilizerInput fertilizer) {
  final weightInGrams =
      double.tryParse(fertilizer.weightController.text) ?? 0.0;

  final nutrient = fertilizer.nutrients[keyNutrientName]!.text;

  if (nutrient.isNotEmpty) {
    final concentration = double.tryParse(nutrient) ?? 0.0;

    final resultInGrams = (concentration * _fertilizerPerKg) / 100;

    print("result in grams per Kg: $resultInGrams");

    final totalNutrientInGram =
        (resultInGrams / _fertilizerPerKg) * weightInGrams;

    print('Total $keyNutrientName: $totalNutrientInGram grams');

    return double.parse(totalNutrientInGram.toStringAsFixed(2));
  }

  return 0.0;
}
