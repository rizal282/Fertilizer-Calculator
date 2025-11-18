import 'package:akurasipupuk/features/fertilizer/domain/ppm/entities/ppm_solution_concentration_entity.dart';

abstract class PpmRepository {
  
  Future<void> saveCountPpmConcentrate(PpmSolutionConcentrationEntity entity);

  Future<List<PpmSolutionConcentrationEntity>> getCountFromPPMForm();

  Future<List<PpmSolutionConcentrationEntity>> getCountHasilHitungMassaZatTerlarut();

  Future<List<PpmSolutionConcentrationEntity>> getCountHasilHitungVolumeLarutan();

  Future<void> deletePPMCountByID(int id);

}