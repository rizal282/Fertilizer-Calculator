import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrient_per_fertilizer_entity.dart';

abstract class RcnpfRepository {
  Future<void> insertRcnpf(ResultCountNutrientPerFertilizerEntity rcnpfEntity);
  Future<List<ResultCountNutrientPerFertilizerEntity>> getAllRcnpfsByIdRacikan(String idRacikan);

  Future<void> deleteRcnpf(String dateNow, String idRacikan);
}