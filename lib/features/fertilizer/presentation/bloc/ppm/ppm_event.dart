import 'package:akurasipupuk/features/fertilizer/domain/ppm/entities/ppm_solution_concentration_entity.dart';

abstract class PpmEvent {}

class SaveCountTotalPpmConcentrateEvent extends PpmEvent {

  final PpmSolutionConcentrationEntity ppmSolutionConcentrationEntity;

  SaveCountTotalPpmConcentrateEvent(this.ppmSolutionConcentrationEntity);
}

class LoadCountResultFromPPMFormEvent extends PpmEvent {}

class LoadHasiHitungMassaZatTerlarutEvent extends PpmEvent {}

class LoadHasilHitungVolumeLarutanEvent extends PpmEvent {}

class DeletePPMCountByIDEvent extends PpmEvent {
  final int id;

  DeletePPMCountByIDEvent(this.id);
}