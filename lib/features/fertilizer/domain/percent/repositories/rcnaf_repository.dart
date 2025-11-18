import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';

abstract class RcnafRepository {
  Future<void> insertRcnaf(ResultCountNutrientsAllFertilizersEntity rcnafEntity);
  Future<List<ResultCountNutrientsAllFertilizersEntity>> getAllRcnafs();

  Future<void> deleteRcnaf(String date, String idRacikan);
}