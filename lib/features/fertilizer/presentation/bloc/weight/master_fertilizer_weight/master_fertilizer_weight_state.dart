import 'package:akurasipupuk/features/fertilizer/data/datasource_global/master_fertilizer_model.dart';

abstract class MasterFertilizerWeightState {}

class MasterFertilizerWeightInitial extends MasterFertilizerWeightState{}

class MasterFertilizerWeightLoading extends MasterFertilizerWeightState{}

class MasterFertilizerWeightLoaded extends MasterFertilizerWeightState{
  final List<MasterFertilizerModel> masterFertilizer;

  MasterFertilizerWeightLoaded(this.masterFertilizer);
}

class MasterFertilizerWeightError extends MasterFertilizerWeightState{
  final String message;

  MasterFertilizerWeightError(this.message);
}