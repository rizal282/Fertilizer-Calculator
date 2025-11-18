import 'package:akurasipupuk/features/fertilizer/data/percent/models/fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/models/nutrient_target_percent_model.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';
import 'package:flutter/material.dart';

Future<bool> updateWeightFertilzer(
    {required BuildContext context,
    required String idRacikan,
    required TextEditingController newTargetWeightMix,
    required NutrientTargetPercentModel nutrientTargetPercentModel,
    required List<FertilizerModel> fertilizersSelected}) async {
  final targetPercentInput = FertilizerTargetInput();
  List<FertilizerWeightInput> fertilizers = [];

  // targetPercentInput.nutrientsTargetPercent[StringConst.NITROGEN]!.text =
  //     nutrientTargetPercentModel.nitrogenPercent.toString();
  // targetPercentInput.nutrientsTargetPercent[StringConst.POSFOR]!.text =
  //     nutrientTargetPercentModel.posforPercent.toString();
  // targetPercentInput.nutrientsTargetPercent[StringConst.KALIUM]!.text =
  //     nutrientTargetPercentModel.kaliumPercent.toString();
  // targetPercentInput.nutrientsTargetPercent[StringConst.KALSIUM]!.text =
  //     nutrientTargetPercentModel.kalsiumPercent.toString();
  // targetPercentInput.nutrientsTargetPercent[StringConst.MAGNESIUM]!.text =
  //     nutrientTargetPercentModel.magnesiumPercent.toString();
  // targetPercentInput.nutrientsTargetPercent[StringConst.SULFUR]!.text =
  //     nutrientTargetPercentModel.sulfurPercent.toString();

  // for (var itemFert in fertilizersSelected) {
  //   final fertilizer = FertilizerWeightInput();

  //   fertilizer.fertilizerNameSelected = itemFert.namaPupuk;
  //   fertilizer.nutrients[StringConst.NITROGEN]!.text =
  //       itemFert.nitrogen.toString();
  //   fertilizer.nutrients[StringConst.POSFOR]!.text = itemFert.posfor.toString();
  //   fertilizer.nutrients[StringConst.KALIUM]!.text = itemFert.kalium.toString();
  //   fertilizer.nutrients[StringConst.KALSIUM]!.text =
  //       itemFert.kalsium.toString();
  //   fertilizer.nutrients[StringConst.MAGNESIUM]!.text =
  //       itemFert.magnesium.toString();
  //   fertilizer.nutrients[StringConst.SULFUR]!.text = itemFert.sulfur.toString();
  //   fertilizer.nutrients[StringConst.MANGAN]!.text = itemFert.mangan.toString();
  //   fertilizer.nutrients[StringConst.BORON]!.text = itemFert.boron.toString();
  //   fertilizer.nutrients[StringConst.MOLIBDENUM]!.text =
  //       itemFert.molibdenum.toString();
  //   fertilizer.nutrients[StringConst.SENG]!.text = itemFert.seng.toString();
  //   fertilizer.nutrients[StringConst.BESI]!.text = itemFert.besi.toString();
  //   fertilizer.nutrients[StringConst.TEMBAGA]!.text =
  //       itemFert.tembaga.toString();

  //   fertilizers.add(fertilizer);
  // }

  // List<FertilizerEntity> listFertilizerSelected = [];
  // for (var fertilizer in fertilizers) {
  //   final weightFertilizerGrams = 0.0;

  //   final nitrogen = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.NITROGEN]!.text)) ??
  //       0.0;

  //   final posfor = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.POSFOR]!.text)) ??
  //       0.0;

  //   final kalium = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.KALIUM]!.text)) ??
  //       0.0;

  //   final boron = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.BORON]!.text)) ??
  //       0.0;

  //   final tembaga = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.TEMBAGA]!.text)) ??
  //       0.0;

  //   final besi = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.BESI]!.text)) ??
  //       0.0;

  //   final magnesium = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.MAGNESIUM]!.text)) ??
  //       0.0;

  //   final mangan = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.MANGAN]!.text)) ??
  //       0.0;

  //   final molibdenum = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.MOLIBDENUM]!.text)) ??
  //       0.0;

  //   final seng = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.SENG]!.text)) ??
  //       0.0;

  //   final kalsium = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.KALSIUM]!.text)) ??
  //       0.0;

  //   final sulfur = double.tryParse(decimalTextContainsCommaFormatter(
  //           fertilizer.nutrients[StringConst.SULFUR]!.text)) ??
  //       0.0;

  //   final fertilizerEntity = FertilizerEntity(
  //       idRacikan: idRacikan,
  //       namaPupuk: fertilizer.fertilizerNameSelected!,
  //       weight: weightFertilizerGrams,
  //       nitrogen: nitrogen,
  //       posfor: posfor,
  //       kalium: kalium,
  //       boron: boron,
  //       tembaga: tembaga,
  //       besi: besi,
  //       magnesium: magnesium,
  //       mangan: mangan,
  //       molibdenum: molibdenum,
  //       seng: seng,
  //       kalsium: kalsium,
  //       sulfur: sulfur);

  //   listFertilizerSelected.add(fertilizerEntity);
  // }

  // final nitrogenPercent = double.tryParse(decimalTextContainsCommaFormatter(
  //         targetPercentInput
  //             .nutrientsTargetPercent[StringConst.NITROGEN]!.text)) ??
  //     0.0;

  // final posforPercent = double.tryParse(decimalTextContainsCommaFormatter(
  //         targetPercentInput
  //             .nutrientsTargetPercent[StringConst.POSFOR]!.text)) ??
  //     0.0;

  // final kaliumPercent = double.tryParse(decimalTextContainsCommaFormatter(
  //         targetPercentInput
  //             .nutrientsTargetPercent[StringConst.KALIUM]!.text)) ??
  //     0.0;

  // final magnesiumPercent = double.tryParse(decimalTextContainsCommaFormatter(
  //         targetPercentInput
  //             .nutrientsTargetPercent[StringConst.MAGNESIUM]!.text)) ??
  //     0.0;

  // final kalsiumPercent = double.tryParse(decimalTextContainsCommaFormatter(
  //         targetPercentInput
  //             .nutrientsTargetPercent[StringConst.KALSIUM]!.text)) ??
  //     0.0;

  // final sulfurPercent = double.tryParse(decimalTextContainsCommaFormatter(
  //         targetPercentInput
  //             .nutrientsTargetPercent[StringConst.SULFUR]!.text)) ??
  //     0.0;

  // final targetPercentNutrient = NutrientTargetPercentEntity(
  //     idRacikan: idRacikan,
  //     weightTarget: double.tryParse(newTargetWeightMix.text)!,
  //     nitrogenPercent: nitrogenPercent,
  //     posforPercent: posforPercent,
  //     kaliumPercent: kaliumPercent,
  //     magnesiumPercent: magnesiumPercent,
  //     kalsiumPercent: kalsiumPercent,
  //     sulfurPercent: sulfurPercent);

  // final adjustWeightFromInput =
  //     CountWeightFertilizerCalculator.countWeightFertilizer(
  //         targetPercentInput, fertilizers,
  //         totalWeightGram: double.parse(newTargetWeightMix.text));

  // List<ResultCountWeightFertilizerMixEntity> listResultWeight = [];

  // adjustWeightFromInput.forEach(
  //   (key, value) {
  //     if (key == "fertilizer_results") {
  //       final valueMap = adjustWeightFromInput[key] as Map<String, dynamic>;

  //       valueMap.forEach(
  //         (keyFertResult, valueFertResult) {
  //           // final keyFertilizerRes = valueMap[keyFertResult];

  //           double doublePercentOfWeight = valueMap[keyFertResult] / 1000 * 100;

  //           final resultCountWeightForFertilizer =
  //               ResultCountWeightFertilizerMixEntity(
  //                   idRacikan: idRacikan,
  //                   fertilizerName: keyFertResult,
  //                   fertilizerRatio: 0.0,
  //                   fertilizerWeight: valueMap[keyFertResult],
  //                   fertilizerPercent:
  //                       double.parse(doublePercentOfWeight.toStringAsFixed(3)));

  //           listResultWeight.add(resultCountWeightForFertilizer);
  //         },
  //       );
  //     }
  //   },
  // );

  // final valueMapNutrients =
  //     adjustWeightFromInput['actual_composition'] as Map<String, dynamic>;

  // final percentAllNutrient = ResultCountNutrientsAllFertilizersEntity(
  //     idRacikan: idRacikan,
  //     fertilizerNames: '',
  //     fertilizerWeightGrams: 0.0,
  //     totalPercentNitrogen: valueMapNutrients[StringConst.NITROGEN],
  //     totalGramNitrogen: percentToGram(valueMapNutrients[StringConst.NITROGEN],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentPosfor: valueMapNutrients[StringConst.POSFOR],
  //     totalGramPosfor: percentToGram(valueMapNutrients[StringConst.POSFOR],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentKalium: valueMapNutrients[StringConst.KALIUM],
  //     totalGramKalium: percentToGram(valueMapNutrients[StringConst.KALIUM],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentBoron: valueMapNutrients[StringConst.BORON],
  //     totalGramBoron: percentToGram(valueMapNutrients[StringConst.BORON],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentTembaga: valueMapNutrients[StringConst.TEMBAGA],
  //     totalGramTembaga: percentToGram(valueMapNutrients[StringConst.TEMBAGA],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentBesi: valueMapNutrients[StringConst.BESI],
  //     totalGramBesi: percentToGram(valueMapNutrients[StringConst.BESI],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentMagnesium: valueMapNutrients[StringConst.MAGNESIUM],
  //     totalGramMagnesium: percentToGram(valueMapNutrients[StringConst.MAGNESIUM],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentMangan: valueMapNutrients[StringConst.MANGAN],
  //     totalGramMangan: percentToGram(valueMapNutrients[StringConst.MANGAN],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentMolibdenum: valueMapNutrients[StringConst.MOLIBDENUM],
  //     totalGramMolibdenum: percentToGram(valueMapNutrients[StringConst.MOLIBDENUM],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentSeng: valueMapNutrients[StringConst.SENG],
  //     totalGramSeng: percentToGram(valueMapNutrients[StringConst.SENG],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentKalsium: valueMapNutrients[StringConst.KALSIUM],
  //     totalGramKalsium: percentToGram(valueMapNutrients[StringConst.KALSIUM],
  //         double.parse(newTargetWeightMix.text)),
  //     totalPercentSulfur: valueMapNutrients[StringConst.SULFUR],
  //     totalGramSulfur: percentToGram(valueMapNutrients[StringConst.SULFUR],
  //         double.parse(newTargetWeightMix.text)),
  //         countType: StringConst.COUNT_TYPE_WEIGHT
  //         );

  // context.read<CountWeightByPercentBloc>().add(UpdateWeightFertilizerEvent(
  //     idRacikan: idRacikan,
  //     fertilizerEntity: listFertilizerSelected,
  //     nutrientTargetPercentEntity: targetPercentNutrient,
  //     resultCountWeightFertilizerMixEntity: listResultWeight,
  //     rcnaf: percentAllNutrient));

  // print(
  //     "UPDATE WEIGH BY $newTargetWeightMix  =========>>>> IS $adjustWeightFromInput");

  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //       content: Text(
  //           "Data diperbarui dengan target berat ${newTargetWeightMix.text}")),
  // );

  // clearFormFertilizerWeight(
  //     fertilizers, targetPercentInput, newTargetWeightMix);

  return true;
}
