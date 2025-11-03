import 'package:pfg_app/features/fertilizer/domain/entities/fertilizer_entity.dart';

abstract class FertilizerRepository {
  Future<void> insertFertilizer(FertilizerEntity fertilizer);
  Future<List<FertilizerEntity>> getAllFertilizers();
  Future<void> deleteFertilizer(String date, String idRacikan);
}