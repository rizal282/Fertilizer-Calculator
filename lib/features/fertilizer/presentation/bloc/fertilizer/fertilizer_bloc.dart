import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfg_app/core/utils/date_format_util.dart';
import 'package:pfg_app/features/fertilizer/domain/repositories/fertilizer_repository.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_state.dart';

class FertilizerBloc extends Bloc<FertilizerEvent, FertilizerState> {
  final FertilizerRepository fertilizerRepository;

  FertilizerBloc(this.fertilizerRepository) : super(FertilizerInitial()) {
    on<AddFertilizerEvent>(_onAddFertilizer);
    on<LoadFertilizersEvent>(_onLoadFertilizers);
    on<DeleteFertilizerEvent>(_deleteFertilizer);
  }

  Future<void> _onAddFertilizer(
      AddFertilizerEvent event, Emitter<FertilizerState> emit) async {
    emit(FertilizerLoading());
    try {
      await fertilizerRepository.insertFertilizer(event.fertilizer);
      add(LoadFertilizersEvent());

      // langsung load ulang data dan emit state baru
      // final fertilizers = await fertilizerRepository.getAllFertilizers();
      // emit(FertilizerLoaded(fertilizers));
    } catch (e) {
      emit(FertilizerError('Failed to add fertilizer: $e'));
    }
  }

  Future<void> _onLoadFertilizers(
      LoadFertilizersEvent event, Emitter<FertilizerState> emit) async {
    emit(FertilizerLoading());
    try {
      final fertilizers = await fertilizerRepository.getAllFertilizers();
      emit(FertilizerLoaded(fertilizers));
    } catch (e) {
      emit(FertilizerError('Failed to load fertilizers: $e'));
    }
  }

  Future<void> _deleteFertilizer(DeleteFertilizerEvent event, Emitter<FertilizerState> emit) async {
    try {
      final dateNow = DateFormatUtil.formatDateToYYYYMMDD(DateTime.now());

      await fertilizerRepository.deleteFertilizer(dateNow, event.idRacikan);
    } catch (e) {
      emit(FertilizerError('Failed to load fertilizers: $e'));
    }
  }
}
