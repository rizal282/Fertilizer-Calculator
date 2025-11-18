import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';

abstract class FertilizerRepository {
  Future<void> insertFertilizer(FertilizerEntity fertilizer);
  Future<List<FertilizerEntity>> getAllFertilizers();
  Future<void> deleteFertilizer(String date, String idRacikan);
}