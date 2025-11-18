import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/utils/decimal_formatter.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/entities/ppm_solution_concentration_entity.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PpmUsecase {
  static Future<void> countPpmConcentrate(BuildContext context, {required String idRacikan, required String volumeLarutan, required double weightFertilizerMix, required String sourcePpm}) async {

    final volumeLarutanParse = double.tryParse(decimalTextContainsCommaFormatter(volumeLarutan)) ?? 0;
      final weightFertilizerMixInMiligrams = weightFertilizerMix * 1000;
      final totalPpmConcentrate = weightFertilizerMixInMiligrams / volumeLarutanParse;
      
      final ppmSolutionConcentrationEntity = PpmSolutionConcentrationEntity(
        idRacikan: idRacikan,
        totalPpm: totalPpmConcentrate,
        totalSolutionVolume: volumeLarutanParse,
        totalMassOfSolute: weightFertilizerMix,
        sourcePpm: sourcePpm,
        countType: StringConst.countTypePPM
      );
      
      context.read<PpmBloc>().add(SaveCountTotalPpmConcentrateEvent(ppmSolutionConcentrationEntity));
  }

  static Future<void> countMassaZatTerlarut({
    required BuildContext context,
    required String idRacikan,
    required String sourcePpm,
    required String volumeLarutan,
    required String nilaiPpm
  }) async {

    // massa zat terlarut = ppm dalam mg * volume larutan L
    final double totalPpmParse = double.parse(decimalTextContainsCommaFormatter(nilaiPpm));
    final double volumeLarutanParse = double.parse(decimalTextContainsCommaFormatter(volumeLarutan));

    // final double massaZatTerlarutMiligram = ;
    final double massaZatTerutGram = totalPpmParse * volumeLarutanParse / 1000;

    final massaZatTerlarutEntity = PpmSolutionConcentrationEntity(
      idRacikan: idRacikan,
      totalPpm: totalPpmParse,
      totalSolutionVolume: volumeLarutanParse,
      totalMassOfSolute: massaZatTerutGram,
      sourcePpm: sourcePpm,
      countType: StringConst.countTypeMassaZatTerlarut
    );

    context.read<PpmBloc>().add(SaveCountTotalPpmConcentrateEvent(massaZatTerlarutEntity));


  }

  static Future<void> countVolumeLarutan({
    required BuildContext context,
    required String idRacikan,
    required String sourcePpm,
    required String massaZatTerlarut,
    required String nilaiKonsetrasiPpm
  }) async {
    // volume larutan = massa zat terlarut (g) / nilai PPM

    final massaZatTerlarutParse = double.parse(decimalTextContainsCommaFormatter(massaZatTerlarut));
    final nilaiKonsentrasiPpm = double.parse(decimalTextContainsCommaFormatter(nilaiKonsetrasiPpm));

    final massaZatTerlarutMiligram = massaZatTerlarutParse * 1000;
    final volumeAirLarutan = massaZatTerlarutMiligram / nilaiKonsentrasiPpm;

    final volumeAirLarutanEntity = PpmSolutionConcentrationEntity(
      idRacikan: idRacikan,
      sourcePpm: sourcePpm,
      countType: StringConst.countTypeVolumeLarutan,
      totalSolutionVolume: volumeAirLarutan,
      totalPpm: nilaiKonsentrasiPpm,
      totalMassOfSolute: massaZatTerlarutParse
    );

    context.read<PpmBloc>().add(SaveCountTotalPpmConcentrateEvent(volumeAirLarutanEntity));

  }

  static Future<void> deletePPMCountByID(BuildContext context, int id) async {
    context.read<PpmBloc>().add(DeletePPMCountByIDEvent(id));
  }
}