import 'package:akurasipupuk/features/fertilizer/domain/weight/repositories/master_fertilizer_repository.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/master_fertilizer_weight/master_fertilizer_weight_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/master_fertilizer_weight/master_fertilizer_weight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MasterFertilizerWeightBloc extends Bloc<MasterFertilizerWeightEvent, MasterFertilizerWeightState> {

  final MasterFertilizerRepository masterFertilizerRepository;

  MasterFertilizerWeightBloc(this.masterFertilizerRepository) : super(MasterFertilizerWeightInitial()) {
    on<LoadMasterFertilizersEvent>(_onLoadMasterFertilizer);
  }

  Future<void> _onLoadMasterFertilizer(LoadMasterFertilizersEvent event, Emitter<MasterFertilizerWeightState> emit) async {

    emit(MasterFertilizerWeightLoading());

    final dataMasterFertilizers = await masterFertilizerRepository.getAllMasterFertilizers();

    print("MASTER DATA FERTILIZER FROM BLOC ${dataMasterFertilizers.length}");

    emit(MasterFertilizerWeightLoaded(dataMasterFertilizers));

  }

}