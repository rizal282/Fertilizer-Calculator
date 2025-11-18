

import 'package:akurasipupuk/features/fertilizer/presentation/model/percent/fertilizer_input.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';

void clearFormFertilizer(List<FertilizerInput> fertilizers) {
  for (var fertilizer in fertilizers) {
    fertilizer.namaPupukController.clear();

    fertilizer.weightController.clear();

    fertilizer.nutrients.forEach((key, value) {
      fertilizer.nutrients[key]!.clear();
    });
  }
}

void clearFormFertilizerWeight(List<FertilizerWeightInput> fertilizers,
    FertilizerTargetInput fertilizerTargetInput) {
  for (var fertilizer in fertilizers) {
    fertilizer.fertilizerNameSelected = null;
    fertilizer.manufacturerName.clear();

    fertilizer.dropdownNamaPupukCtrl.reset?.call();

    fertilizer.weightGramInput.clear();

    fertilizer.nutrients.forEach((key, value) {
      fertilizer.nutrients[key]!.clear();
    });
  }

  fertilizerTargetInput.nutrientsTargetPercent.forEach((key, value) {
    fertilizerTargetInput.nutrientsTargetPercent[key]!.clear();
  });
}
