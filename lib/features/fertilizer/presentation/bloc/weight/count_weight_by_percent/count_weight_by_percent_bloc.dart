import 'package:akurasipupuk/features/fertilizer/domain/weight/repositories/count_weight_by_percent_target_repository.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountWeightByPercentBloc
    extends Bloc<CountWeightByPercentEvent, CountWeightByPercentState> {
  final CountWeightByPercentTargetRepository
      countWeightByPercentTargetRepository;

  CountWeightByPercentBloc(this.countWeightByPercentTargetRepository)
      : super(CountWeightByPercentInitial()) {
    on<SaveCountWeightByPercentEvent>(_onSaveCountWeightByPercent);
    on<LoadCountWeightByPercentEvent>(_onCountWeightByPercentLoad);
    on<DeleteCountWeightByPercentEvent>(
        _onDeleteFertilierWeightMixAndTargetPercent);

    on<UpdateWeightFertilizerEvent>(_onUpdateCountWeightFeertilizer);
  }

  Future<void> _onUpdateCountWeightFeertilizer(
      UpdateWeightFertilizerEvent event,
      Emitter<CountWeightByPercentState> emit) async {
        
    countWeightByPercentTargetRepository
        .updateCountWeightFertilizer(
            idRacikan: event.idRacikan,
            listFertilizerSelected: event.fertilizerEntity,
            nutrientTargetPercentEntity: event.nutrientTargetPercentEntity,
            listResultWeight: event.resultCountWeightFertilizerMixEntity,
            rcnaf: event.rcnaf)
        .then(
      (_) {
        add(LoadCountWeightByPercentEvent());
      },
    );
  }

  Future<void> _onDeleteFertilierWeightMixAndTargetPercent(
      DeleteCountWeightByPercentEvent event,
      Emitter<CountWeightByPercentState> emit) async {
    countWeightByPercentTargetRepository
        .deleteFertilierWeightMixAndTargetPercent(event.idRacikan)
        .then((_) {
      add(LoadCountWeightByPercentEvent());
    });
  }

  Future<void> _onSaveCountWeightByPercent(SaveCountWeightByPercentEvent event,
      Emitter<CountWeightByPercentState> emit) async {
    await countWeightByPercentTargetRepository.saveCountWeightByPercentTarget(
        event.fertilizerEntity,
        event.nutrientTargetPercentEntity,
        event.resultCountWeightFertilizerMixEntity,
        event.atpe, event.dtpe);

    add(LoadCountWeightByPercentEvent());
  }

  Future<void> _onCountWeightByPercentLoad(LoadCountWeightByPercentEvent event,
      Emitter<CountWeightByPercentState> emit) async {
        emit(CountWeightByPercentLoading());
        
    final dataWeightEachFertilizer = await countWeightByPercentTargetRepository
        .getAllCountWeightByPercentTarget();

    emit(CountWeightByPercentLoaded(dataWeightEachFertilizer));
  }
}
