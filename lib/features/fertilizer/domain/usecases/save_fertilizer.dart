import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pfg_app/core/constants/string_const.dart';
import 'package:pfg_app/core/utils/unique_id_racikan_generator.dart';
import 'package:pfg_app/features/fertilizer/domain/entities/fertilizer_entity.dart';
import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrient_per_fertilizer_entity.dart';
import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:pfg_app/features/fertilizer/domain/utils/count_percent_grams_nutrient.dart';
import 'package:pfg_app/features/fertilizer/domain/utils/count_total_nutrient_grams.dart';
import 'package:pfg_app/features/fertilizer/domain/utils/count_total_nutrient_percent.dart';
import 'package:pfg_app/features/fertilizer/domain/utils/validate_fertilizer_form.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnpf/rcnpf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/model/fertilizer_input.dart';

var _logger = Logger();

Future<void> _countNutrientsInPercentAndGrams(BuildContext context,
    String idRacikan, List<FertilizerInput> fertilizers) async {
  // rumus: kandungan nutrisi per kg / 1000 gram * berat pupuk dalam gram

  // rumus mencari jumlah nutrisi dalam 1000 gram pupuk:
  // persen nutrisi * 1000 gram / 100

  // rumus mencari jumlah nutrisi per gram pupuk:
  // jumlah nutrisi dalam 1000 gram pupuk / 1000 gram * berat pupuk dalam gram

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
          countNutrientPercent(StringConst.NITROGEN, fertilizer),
      totalGramNitrogen: countNutrientGram(StringConst.NITROGEN, fertilizer),
      totalPercentPosfor: countNutrientPercent(StringConst.POSFOR, fertilizer),
      totalGramPosfor: countNutrientGram(StringConst.POSFOR, fertilizer),
      totalPercentKalium: countNutrientPercent(StringConst.KALIUM, fertilizer),
      totalGramKalium: countNutrientGram(StringConst.KALIUM, fertilizer),
      totalPercentBoron: countNutrientPercent(StringConst.BORON, fertilizer),
      totalGramBoron: countNutrientGram(StringConst.BORON, fertilizer),
      totalPercentTembaga:
          countNutrientPercent(StringConst.TEMBAGA, fertilizer),
      totalGramTembaga: countNutrientGram(StringConst.TEMBAGA, fertilizer),
      totalPercentBesi: countNutrientPercent(StringConst.BESI, fertilizer),
      totalGramBesi: countNutrientGram(StringConst.BESI, fertilizer),
      totalPercentMagnesium:
          countNutrientPercent(StringConst.MAGNESIUM, fertilizer),
      totalGramMagnesium: countNutrientGram(StringConst.MAGNESIUM, fertilizer),
      totalPercentMangan: countNutrientPercent(StringConst.MANGAN, fertilizer),
      totalGramMangan: countNutrientGram(StringConst.MANGAN, fertilizer),
      totalPercentMolibdenum:
          countNutrientPercent(StringConst.MOLIBDENUM, fertilizer),
      totalGramMolibdenum:
          countNutrientGram(StringConst.MOLIBDENUM, fertilizer),
          
      totalPercentSeng: countNutrientPercent(StringConst.SENG, fertilizer),
      totalGramSeng: countNutrientGram(StringConst.SENG, fertilizer),

      totalPercentKalsium: countNutrientGram(StringConst.KALSIUM, fertilizer),
      totalGramKalsium: countNutrientPercent(StringConst.KALSIUM, fertilizer),
      
      totalPercentSulfur: countNutrientGram(StringConst.SULFUR, fertilizer),
      totalGramSulfur: countNutrientPercent(StringConst.SULFUR, fertilizer),
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
      totalGramSulfur: totalSulfurInGrams
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
        double.tryParse(fertilizer.weightController.text) ?? 0.0;
    final nitrogen =
        double.tryParse(fertilizer.nutrients[StringConst.NITROGEN]!.text) ??
            0.0;
    final posfor =
        double.tryParse(fertilizer.nutrients[StringConst.POSFOR]!.text) ?? 0.0;
    final kalium =
        double.tryParse(fertilizer.nutrients[StringConst.KALIUM]!.text) ?? 0.0;
    final boron =
        double.tryParse(fertilizer.nutrients[StringConst.BORON]!.text) ?? 0.0;
    final tembaga =
        double.tryParse(fertilizer.nutrients[StringConst.TEMBAGA]!.text) ?? 0.0;
    final besi =
        double.tryParse(fertilizer.nutrients[StringConst.BESI]!.text) ?? 0.0;
    final magnesium =
        double.tryParse(fertilizer.nutrients[StringConst.MAGNESIUM]!.text) ??
            0.0;
    final mangan =
        double.tryParse(fertilizer.nutrients[StringConst.MANGAN]!.text) ?? 0.0;
    final molibdenum =
        double.tryParse(fertilizer.nutrients[StringConst.MOLIBDENUM]!.text) ??
            0.0;
    final seng =
        double.tryParse(fertilizer.nutrients[StringConst.SENG]!.text) ?? 0.0;

    final kalsium =
        double.tryParse(fertilizer.nutrients[StringConst.KALSIUM]!.text) ?? 0.0;

    final sulfur =
        double.tryParse(fertilizer.nutrients[StringConst.SULFUR]!.text) ?? 0.0;

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
