import 'package:pfg_app/features/fertilizer/presentation/model/fertilizer_input.dart';

void clearFormFertilizer(List<FertilizerInput> fertilizers) {
  for (var fertilizer in fertilizers) {
    fertilizer.namaPupukController.clear();
    fertilizer.weightController.clear();
    
    fertilizer.nutrients.forEach((key, value) {
      fertilizer.nutrients[key]!.clear();
    });
  }
  
}