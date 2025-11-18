import 'package:akurasipupuk/core/datasource/internal/data_master_fertilizers.dart';
import 'package:akurasipupuk/features/fertilizer/data/datasource_global/master_fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/repositories/master_fertilizer_repository.dart';

class MasterFertilizerRepositoryImpl implements MasterFertilizerRepository {
  @override
  Future<List<MasterFertilizerModel>> getAllMasterFertilizers() async {
    final dataMasterFertilizers = await loadDataMasterFertilizers();

    print("MASTER DATA FERTILIZER ${dataMasterFertilizers.length}");

    return dataMasterFertilizers;
  }



}