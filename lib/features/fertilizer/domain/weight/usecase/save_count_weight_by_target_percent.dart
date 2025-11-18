import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/utils/decimal_formatter.dart';
import 'package:akurasipupuk/core/utils/unique_id_racikan_generator.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/utils/count_weight_fertilizer_calculator.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/accuracy_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/deviation_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/nutrient_target_percent_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/result_count_weight_fertilizer_mix_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/utils/validate_input_count_weight_fertilizer.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

var log = Logger();

Future<bool> saveCountWeightByTargetPercent(
  BuildContext context,
  FertilizerTargetInput targetPercentInput,
  List<FertilizerWeightInput> fertilizers,
) async {

  final User? user = FirebaseAuth.instance.currentUser;

  final formIsValid = validateInputCountWeightFertilizer(
      context, fertilizers, targetPercentInput);

  if (!formIsValid) {
    return false;
  }

  final idRacikan = uniqueIdRacikanGenerator();

  // example final count weight after mix fertilizer
  // {Urea: 155.533, Meroke PLUS (NPK + TE): 448.482, MerokeFOSFAT: 146.932}

  List<FertilizerEntity> listFertilizerSelected = [];
  for (var fertilizer in fertilizers) {
    final weightFertilizerGrams = double.tryParse(
        decimalTextContainsCommaFormatter(fertilizer.weightGramInput.text));

    final nitrogen = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.nitrogen]!.text)) ??
        0.0;

    final posfor = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.posfor]!.text)) ??
        0.0;

    final kalium = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.kalium]!.text)) ??
        0.0;

    final boron = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.boron]!.text)) ??
        0.0;

    final tembaga = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.tembaga]!.text)) ??
        0.0;

    final besi = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.besi]!.text)) ??
        0.0;

    final magnesium = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.magnesium]!.text)) ??
        0.0;

    final mangan = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.mangan]!.text)) ??
        0.0;

    final molibdenum = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.molibdenum]!.text)) ??
        0.0;

    final seng = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.seng]!.text)) ??
        0.0;

    final kalsium = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.kalsium]!.text)) ??
        0.0;

    final sulfur = double.tryParse(decimalTextContainsCommaFormatter(
            fertilizer.nutrients[StringConst.sulfur]!.text)) ??
        0.0;

    final fertilizerEntity = FertilizerEntity(
        idRacikan: idRacikan,
        namaPupuk: fertilizer.fertilizerNameSelected ?? '-',
        weight: weightFertilizerGrams ?? 0.0,
        nitrogen: nitrogen,
        posfor: posfor,
        kalium: kalium,
        boron: boron,
        tembaga: tembaga,
        besi: besi,
        magnesium: magnesium,
        mangan: mangan,
        molibdenum: molibdenum,
        seng: seng,
        kalsium: kalsium,
        sulfur: sulfur);

    listFertilizerSelected.add(fertilizerEntity);
  }

  final nitrogenPercent = double.tryParse(decimalTextContainsCommaFormatter(
          targetPercentInput
              .nutrientsTargetPercent[StringConst.nitrogen]!.text)) ??
      0.0;

  final posforPercent = double.tryParse(decimalTextContainsCommaFormatter(
          targetPercentInput
              .nutrientsTargetPercent[StringConst.posfor]!.text)) ??
      0.0;

  final kaliumPercent = double.tryParse(decimalTextContainsCommaFormatter(
          targetPercentInput
              .nutrientsTargetPercent[StringConst.kalium]!.text)) ??
      0.0;

  final magnesiumPercent = double.tryParse(decimalTextContainsCommaFormatter(
          targetPercentInput
              .nutrientsTargetPercent[StringConst.magnesium]!.text)) ??
      0.0;

  final kalsiumPercent = double.tryParse(decimalTextContainsCommaFormatter(
          targetPercentInput
              .nutrientsTargetPercent[StringConst.kalsium]!.text)) ??
      0.0;

  final sulfurPercent = double.tryParse(decimalTextContainsCommaFormatter(
          targetPercentInput
              .nutrientsTargetPercent[StringConst.sulfur]!.text)) ??
      0.0;

  final targetPercentNutrient = NutrientTargetPercentEntity(
      idUser: user!.uid,
      idRacikan: idRacikan,
      weightTarget: 0.0,
      nitrogenPercent: nitrogenPercent,
      posforPercent: posforPercent,
      kaliumPercent: kaliumPercent,
      magnesiumPercent: magnesiumPercent,
      kalsiumPercent: kalsiumPercent,
      sulfurPercent: sulfurPercent);

  final resultCount = CountWeightFertilizerCalculator.countWeightFertilizer(
    targetPercentInput,
    fertilizers,
  );

  // List<ResultCountWeightFertilizerMixEntity> listResultWeight = [];

  final nutrientContentPercentResult =
      resultCount['percentResult'] as Map<String, dynamic>;

  final resultCountWeightForFertilizer = ResultCountWeightFertilizerMixEntity(
      idRacikan: idRacikan,
      nitrogenPercent: nutrientContentPercentResult[StringConst.nitrogen],
      posforPercent: nutrientContentPercentResult[StringConst.posfor],
      kaliumPercent: nutrientContentPercentResult[StringConst.kalium],
      boronPercent: nutrientContentPercentResult[StringConst.boron],
      tembagaPercent: nutrientContentPercentResult[StringConst.tembaga],
      besiPercent: nutrientContentPercentResult[StringConst.besi],
      magnesiumPercent: nutrientContentPercentResult[StringConst.magnesium],
      manganPercent: nutrientContentPercentResult[StringConst.mangan],
      molibdenumPercent: nutrientContentPercentResult[StringConst.molibdenum],
      sengPercent: nutrientContentPercentResult[StringConst.seng],
      kalsiumPercent: nutrientContentPercentResult[StringConst.kalsium],
      sulfurPercent: nutrientContentPercentResult[StringConst.sulfur]);

  final accuracyData = resultCount['accuracy'] as Map<String, dynamic>;

  final accuracyTargetResultData = AccuracyTargetPercentEntity(
    idRacikan: idRacikan,
    nitrogenPercent: accuracyData[StringConst.nitrogen],
    posforPercent: accuracyData[StringConst.posfor],
    kaliumPercent: accuracyData[StringConst.kalium],
    kalsiumPercent: accuracyData[StringConst.kalsium],
    sulfurPercent: accuracyData[StringConst.sulfur],
    magnesiumPercent: accuracyData[StringConst.magnesium],
    boronPercent: 0.0,
    tembagaPercent: 0.0,
    besiPercent: 0.0,
    manganPercent: 0.0,
    molibdenumPercent: 0.0,
    sengPercent: 0.0,
  );

  final deviationData = resultCount['deviation'] as Map<String, dynamic>;

  final deviationTargetResultData = DeviationTargetPercentEntity(
    idRacikan: idRacikan,
    nitrogenPercent: deviationData[StringConst.nitrogen],
    posforPercent: deviationData[StringConst.posfor],
    kaliumPercent: deviationData[StringConst.kalium],
    kalsiumPercent: deviationData[StringConst.kalsium],
    sulfurPercent: deviationData[StringConst.sulfur],
    magnesiumPercent: deviationData[StringConst.magnesium],
    boronPercent: 0.0,
    tembagaPercent: 0.0,
    besiPercent: 0.0,
    manganPercent: 0.0,
    molibdenumPercent: 0.0,
    sengPercent: 0.0,
  );

  log.i("DATA BERAT YANG HARUS DIAMBIL ===>> $resultCount");

  context.read<CountWeightByPercentBloc>().add(SaveCountWeightByPercentEvent(
      listFertilizerSelected,
      targetPercentNutrient,
      resultCountWeightForFertilizer,
      accuracyTargetResultData,
      deviationTargetResultData));

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Data berhasil disimpan")),
  );

  // final valueMapNutrients =
  //     resultCount['actual_composition'] as Map<String, dynamic>;

  // final percentAllNutrient = ResultCountNutrientsAllFertilizersEntity(
  //     idRacikan: idRacikan,
  //     fertilizerNames: '',
  //     fertilizerWeightGrams: 0.0,
  //     totalPercentNitrogen: valueMapNutrients[StringConst.NITROGEN],
  //     totalGramNitrogen: percentToGram(valueMapNutrients[StringConst.NITROGEN], 100),
  //     totalPercentPosfor: valueMapNutrients[StringConst.POSFOR],
  //     totalGramPosfor: percentToGram(valueMapNutrients[StringConst.POSFOR], 100),
  //     totalPercentKalium: valueMapNutrients[StringConst.KALIUM],
  //     totalGramKalium: percentToGram(valueMapNutrients[StringConst.KALIUM], 100),
  //     totalPercentBoron: valueMapNutrients[StringConst.BORON],
  //     totalGramBoron: percentToGram(valueMapNutrients[StringConst.BORON], 100),
  //     totalPercentTembaga: valueMapNutrients[StringConst.TEMBAGA],
  //     totalGramTembaga: percentToGram(valueMapNutrients[StringConst.TEMBAGA], 100),
  //     totalPercentBesi: valueMapNutrients[StringConst.BESI],
  //     totalGramBesi: percentToGram(valueMapNutrients[StringConst.BESI], 100),
  //     totalPercentMagnesium: valueMapNutrients[StringConst.MAGNESIUM],
  //     totalGramMagnesium: percentToGram(valueMapNutrients[StringConst.MAGNESIUM], 100),
  //     totalPercentMangan: valueMapNutrients[StringConst.MANGAN],
  //     totalGramMangan: percentToGram(valueMapNutrients[StringConst.MANGAN], 100),
  //     totalPercentMolibdenum: valueMapNutrients[StringConst.MOLIBDENUM],
  //     totalGramMolibdenum: percentToGram(valueMapNutrients[StringConst.MOLIBDENUM], 100),
  //     totalPercentSeng: valueMapNutrients[StringConst.SENG],
  //     totalGramSeng: percentToGram(valueMapNutrients[StringConst.SENG], 100),
  //     totalPercentKalsium: valueMapNutrients[StringConst.KALSIUM],
  //     totalGramKalsium: percentToGram(valueMapNutrients[StringConst.KALSIUM], 100),
  //     totalPercentSulfur: valueMapNutrients[StringConst.SULFUR],
  //     totalGramSulfur: percentToGram(valueMapNutrients[StringConst.SULFUR], 100),
  //     countType: StringConst.COUNT_TYPE_WEIGHT
  //     );

  return true;
}
