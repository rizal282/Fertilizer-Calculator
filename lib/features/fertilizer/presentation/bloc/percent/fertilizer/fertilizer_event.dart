import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';

abstract class FertilizerEvent {}

class AddFertilizerEvent extends FertilizerEvent {
  final FertilizerEntity fertilizer;
  AddFertilizerEvent(this.fertilizer);
}

class DeleteFertilizerEvent extends FertilizerEvent {
  final String idRacikan;

  DeleteFertilizerEvent({required this.idRacikan});
}

class LoadFertilizersEvent extends FertilizerEvent {}
