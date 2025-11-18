import 'package:akurasipupuk/features/fertilizer/domain/ppm/entities/ppm_solution_concentration_entity.dart';

abstract class PpmState {}

class CountPpmConcentrateInitial extends PpmState {}

class CountPpmConcentrateLoading extends PpmState {}

class CountPpmConcentrateLoaded extends PpmState {}

class CountPpmConcentrateError extends PpmState {
  final String message;

  CountPpmConcentrateError(this.message);
}


// count PPM from input form
class CountResultFromPPMFormLoading extends PpmState {}

class CountResultFromPPMFormLoaded extends PpmState {
  final List<PpmSolutionConcentrationEntity> dataCountResult;

  CountResultFromPPMFormLoaded(this.dataCountResult);
}

// massa zat terlarut
class CountResultMassaZatTerlarutLoading extends PpmState {}

class CountResultMassaZatTerlarutLoaded extends PpmState {
  final List<PpmSolutionConcentrationEntity>  dataCountResult;

  CountResultMassaZatTerlarutLoaded(this.dataCountResult);
}

// volume larutan
class CountResultVolumeLarutanLoading extends PpmState {}

class CountResultVolumeLarutanLoaded extends PpmState {
  final List<PpmSolutionConcentrationEntity>  dataCountResult;

  CountResultVolumeLarutanLoaded(this.dataCountResult);
}

