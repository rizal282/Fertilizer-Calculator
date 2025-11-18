import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';
import 'package:flutter/material.dart';


bool validateInputCountWeightFertilizer(
    BuildContext context,
    List<FertilizerWeightInput> fertilizerWeightInputs,
    FertilizerTargetInput targetPercentInput,) {
  for (var itemInputFertilizerSelected in fertilizerWeightInputs) {
    if (itemInputFertilizerSelected.fertilizerNameSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pilih Minimal 2 Pupuk Dahulu!")),
      );

      return false;
    }
  }

  final percentNitrogen =
      targetPercentInput.nutrientsTargetPercent["Nitrogen"]!.text;
  final percentPosfor =
      targetPercentInput.nutrientsTargetPercent["Posfor"]!.text;
  final percentKalium =
      targetPercentInput.nutrientsTargetPercent["Kalium"]!.text;

  if (percentNitrogen.isEmpty ||
      percentPosfor.isEmpty ||
      percentKalium.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Masukkan Dahulu Target Kadar Unsur!")),
    );

    return false;
  }

  // if (targetWeightAfterMix.isEmpty) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Masukkan Dahulu Berat Setelah Dicampur!")),
  //   );

  //   return false;
  // }

  return true;
}
