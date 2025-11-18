// rcnpf is Result of Calculation Nutrients for Per Fertilizer


import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrient_per_fertilizer_entity.dart';

abstract class RcnpfEvent {}

class AddRcnpfEvent extends RcnpfEvent {
  final ResultCountNutrientPerFertilizerEntity entity;  
  AddRcnpfEvent(this.entity);
} 

class DeleteRcnpfEvent extends RcnpfEvent {
  final String idRacikan;

  DeleteRcnpfEvent({ required this.idRacikan });
}

class LoadRcnpfEvent extends RcnpfEvent {}