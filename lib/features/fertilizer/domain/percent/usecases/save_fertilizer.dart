import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/utils/decimal_formatter.dart';
import 'package:akurasipupuk/core/utils/unique_id_racikan_generator.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrient_per_fertilizer_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/utils/count_percent_grams_nutrient.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/utils/count_total_nutrient_grams.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/utils/count_total_nutrient_percent.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/utils/validate_fertilizer_form.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/fertilizer/fertilizer_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/fertilizer/fertilizer_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnpf/rcnpf_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/percent/fertilizer_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

var _logger = Logger();

Future<void> _countNutrientsInPercentAndGrams(BuildContext context,
    String idRacikan, List<FertilizerInput> fertilizers) async {

  for (var fertilizer in fertilizers) {
    if (!isFertilizerFormValid(context, fertilizer)) {
      return;
    }

    final fertilizerName = fertilizer.namaPupukController.text;
    final weightInGrams =
        double.tryParse(fertilizer.weightController.text) ?? 0.0;

    final rcnpfEntity = ResultCountNutrientPerFertilizerEntity(
      idRacikan: idRacikan,
      fertilizerName: fertilizerName,
      fertilizerWeightGrams: weightInGrams,
      totalPercentNitrogen:
          countNutrientPercent(StringConst.nitrogen, fertilizer),
      totalGramNitrogen: countNutrientGram(StringConst.nitrogen, fertilizer),
      totalPercentPosfor: countNutrientPercent(StringConst.posfor, fertilizer),
      totalGramPosfor: countNutrientGram(StringConst.posfor, fertilizer),
      totalPercentKalium: countNutrientPercent(StringConst.kalium, fertilizer),
      totalGramKalium: countNutrientGram(StringConst.kalium, fertilizer),
      totalPercentBoron: countNutrientPercent(StringConst.boron, fertilizer),
      totalGramBoron: countNutrientGram(StringConst.boron, fertilizer),
      totalPercentTembaga:
          countNutrientPercent(StringConst.tembaga, fertilizer),
      totalGramTembaga: countNutrientGram(StringConst.tembaga, fertilizer),
      totalPercentBesi: countNutrientPercent(StringConst.besi, fertilizer),
      totalGramBesi: countNutrientGram(StringConst.besi, fertilizer),
      totalPercentMagnesium:
          countNutrientPercent(StringConst.magnesium, fertilizer),
      totalGramMagnesium: countNutrientGram(StringConst.magnesium, fertilizer),
      totalPercentMangan: countNutrientPercent(StringConst.mangan, fertilizer),
      totalGramMangan: countNutrientGram(StringConst.mangan, fertilizer),
      totalPercentMolibdenum:
          countNutrientPercent(StringConst.molibdenum, fertilizer),
      totalGramMolibdenum:
          countNutrientGram(StringConst.molibdenum, fertilizer),

      totalPercentSeng: countNutrientPercent(StringConst.seng, fertilizer),
      totalGramSeng: countNutrientGram(StringConst.seng, fertilizer),

      totalPercentKalsium: countNutrientGram(StringConst.kalsium, fertilizer),
      totalGramKalsium: countNutrientPercent(StringConst.kalsium, fertilizer),
      
      totalPercentSulfur: countNutrientGram(StringConst.sulfur, fertilizer),
      totalGramSulfur: countNutrientPercent(StringConst.sulfur, fertilizer),
      // createdAt: DateTime.now().toString()
    );

    _logger.i("KADAR GRAM KALSIUM ${rcnpfEntity.totalGramKalsium}");
    _logger.i("KADAR PERCENT KALSIUM ${rcnpfEntity.totalPercentKalsium}");

    _logger.i("KADAR GRAM SULFUR ${rcnpfEntity.totalGramSulfur}");
    _logger.i("KADAR PERCENT SULFUR ${rcnpfEntity.totalPercentSulfur}");

    await context.read<RcnpfBloc>().rcnpfRepository.insertRcnpf(rcnpfEntity);
  }

  _logger.i("====================================");
}

Future<void> _saveAllCountFertilizerNutrients(BuildContext context,
    String idRacikan, List<FertilizerInput> fertilizers) async {
  context
      .read<RcnpfBloc>()
      .rcnpfRepository
      .getAllRcnpfsByIdRacikan(idRacikan)
      .then((rcnpfList) async {

    final User? user = FirebaseAuth.instance.currentUser;

    _logger.i("Saved RCNFP List:${rcnpfList.length}");

    final fertilizerNames = rcnpfList.map((e) => e.fertilizerName).join(', ');

    final totalAllWeightFertilizers = rcnpfList.fold<double>(
        0.0, (sum, item) => sum + item.fertilizerWeightGrams);

    _logger.i("Total Weight Fertilizers: $totalAllWeightFertilizers g");

    final totalNitrogenInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_nitrogen');

    final totalNitrogenInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_nitrogen');

    final totalPosforInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_posfor');

    final totalPosforInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_posfor');

    final totalKaliumInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_kalium');

    final totalKaliumInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_kalium');

    final totalBoronInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_boron');

    final totalBoronInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_boron');

    final totalTembagaInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_tembaga');

    final totalTembagaInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_tembaga');

    final totalBesiInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_besi');

    final totalBesiInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_besi');

    final totalMagnesiumInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_magnesium');

    final totalMagnesiumInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_magnesium');

    final totalManganInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_mangan');

    final totalManganInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_mangan');

    final totalMolibdenumInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_molibdenum');

    final totalMolibdenumInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_molibdenum');

    final totalSengInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_seng');

    final totalSengInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_seng');

    final totalKalsiumInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_kalsium');

    final totalKalsiumInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_kalsium');

    final totalSulfurInGrams = countNutrientGrams(
        totalAllWeightFertilizers, rcnpfList, 'total_gram_sulfur');

    final totalSulfurInPercent = countNutrientPercents(
        totalAllWeightFertilizers, rcnpfList, 'total_percent_sulfur');

    final rcnafEntity = ResultCountNutrientsAllFertilizersEntity(
      idUser: user!.uid,
      idRacikan: idRacikan,
      fertilizerNames: fertilizerNames,
      fertilizerWeightGrams: totalAllWeightFertilizers,
      totalPercentNitrogen: totalNitrogenInPercent,
      totalGramNitrogen: totalNitrogenInGrams,
      totalPercentPosfor: totalPosforInPercent,
      totalGramPosfor: totalPosforInGrams,
      totalPercentKalium: totalKaliumInPercent,
      totalGramKalium: totalKaliumInGrams,
      totalPercentBoron: totalBoronInPercent,
      totalGramBoron: totalBoronInGrams,
      totalPercentTembaga: totalTembagaInPercent,
      totalGramTembaga: totalTembagaInGrams,
      totalPercentBesi: totalBesiInPercent,
      totalGramBesi: totalBesiInGrams,
      totalPercentMagnesium: totalMagnesiumInPercent,
      totalGramMagnesium: totalMagnesiumInGrams,
      totalPercentMangan: totalManganInPercent,
      totalGramMangan: totalManganInGrams,
      totalPercentMolibdenum: totalMolibdenumInPercent,
      totalGramMolibdenum: totalMolibdenumInGrams,
      totalPercentSeng: totalSengInPercent,
      totalGramSeng: totalSengInGrams,
      totalPercentKalsium: totalKalsiumInPercent,
      totalGramKalsium: totalKalsiumInGrams,
      totalPercentSulfur: totalSulfurInPercent,
      totalGramSulfur: totalSulfurInGrams,
      countType: StringConst.countTypePercent
    );

    await context.read<RcnafBloc>().rcnafRepository.insertRcnaf(rcnafEntity);
    await Future.delayed(
        const Duration(milliseconds: 300)); // beri waktu DB selesai
    context.read<RcnafBloc>().add(LoadRcnafEvent());
  });
}

Future<bool> saveDataFertilizer(
    BuildContext context, List<FertilizerInput> fertilizers) async {
  String idRacikan = uniqueIdRacikanGenerator();

  for (var fertilizer in fertilizers) {
    if (!isFertilizerFormValid(context, fertilizer)) {
      return false;
    }

    final weightFertilizerGrams =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.weightController.text)) ?? 0.0;

    final nitrogen =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.nitrogen]!.text)) ??
            0.0;

    final posfor =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.posfor]!.text)) ?? 0.0;

    final kalium =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.kalium]!.text)) ?? 0.0;

    final boron =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.boron]!.text)) ?? 0.0;

    final tembaga =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.tembaga]!.text)) ?? 0.0;

    final besi =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.besi]!.text)) ?? 0.0;

    final magnesium =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.magnesium]!.text)) ??
            0.0;

    final mangan =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.mangan]!.text)) ?? 0.0;

    final molibdenum =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.molibdenum]!.text)) ??
            0.0;

    final seng =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.seng]!.text)) ?? 0.0;

    final kalsium =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.kalsium]!.text)) ?? 0.0;

    final sulfur =
        double.tryParse(decimalTextContainsCommaFormatter(fertilizer.nutrients[StringConst.sulfur]!.text)) ?? 0.0;

    final fertilizerEntity = FertilizerEntity(
        idRacikan: idRacikan,
        namaPupuk: fertilizer.namaPupukController.text,
        weight: weightFertilizerGrams,
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

    context.read<FertilizerBloc>().add(AddFertilizerEvent(fertilizerEntity));
  }

  await _countNutrientsInPercentAndGrams(context, idRacikan, fertilizers);

  await _saveAllCountFertilizerNutrients(context, idRacikan, fertilizers);

  _logger.i('✅ Data pupuk berhasil disimpan');

  return true;
}
