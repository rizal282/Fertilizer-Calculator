
import 'package:akurasipupuk/features/fertilizer/data/datasource_global/master_fertilizer_model.dart';

abstract class MasterFertilizerRepository {
  Future<List<MasterFertilizerModel>> getAllMasterFertilizers();
}