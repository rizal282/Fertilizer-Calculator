import 'package:akurasipupuk/core/utils/decimal_formatter.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/percent/fertilizer_input.dart';
import 'package:logger/logger.dart';

double countNutrientPercent(
    String keyNutrientName, FertilizerInput fertilizer) {

      var logger = Logger();

  final fertilizerName = fertilizer.namaPupukController.text;

  final weightFormatDecimal = decimalTextContainsCommaFormatter(fertilizer.weightController.text);

  final weightInGrams =
      double.tryParse(weightFormatDecimal) ?? 0.0;

  final nutrient = fertilizer.nutrients[keyNutrientName]!.text;

  if (nutrient.isNotEmpty) {
    final formatFromDecimalText = decimalTextContainsCommaFormatter(nutrient);
    final concentration = double.tryParse(formatFromDecimalText) ?? 0.0;

    final resultInPercent = concentration * weightInGrams / 100;

    logger.i("KADAR $keyNutrientName DI $fertilizerName ================>> $resultInPercent");

    return double.parse(resultInPercent.toStringAsFixed(3));
  }

  return 0.0;
}

double countNutrientGram(String keyNutrientName, FertilizerInput fertilizer) {
  // final double fertilizerPerKg = 1000.0;

  final weightFormatDecimal = decimalTextContainsCommaFormatter(fertilizer.weightController.text);

  final weightInGrams =
      double.tryParse(weightFormatDecimal) ?? 0.0;

  final nutrient = fertilizer.nutrients[keyNutrientName]!.text;

  if (nutrient.isNotEmpty) {
    final formatFromDecimalText = decimalTextContainsCommaFormatter(nutrient);
    final concentration = double.tryParse(formatFromDecimalText) ?? 0.0;

    // final resultInGrams = (concentration * fertilizerPerKg) / 100;

    // print("result in grams per Kg: $resultInGrams");

    final totalNutrientInGram =
        (concentration / 100) * weightInGrams;

    print('Total $keyNutrientName: $totalNutrientInGram grams');

    return double.parse(totalNutrientInGram.toStringAsFixed(3));
  }

  return 0.0;
}
