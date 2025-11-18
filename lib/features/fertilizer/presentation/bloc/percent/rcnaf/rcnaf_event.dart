import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';

abstract class RcnafEvent {}

class AddRcnafEvent extends RcnafEvent {
  final ResultCountNutrientsAllFertilizersEntity nutrientCounts;  
  AddRcnafEvent(this.nutrientCounts);
}

class DeleteRcnafEvent extends RcnafEvent {
  final String idRacikan;

  DeleteRcnafEvent({required this.idRacikan});
}

class LoadRcnafEvent extends RcnafEvent {}