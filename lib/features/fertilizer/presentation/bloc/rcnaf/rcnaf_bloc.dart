import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfg_app/core/utils/date_format_util.dart';
import 'package:pfg_app/features/fertilizer/domain/repositories/rcnaf_repository.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_state.dart';

class RcnafBloc extends Bloc<RcnafEvent, RcnafState> {
  final RcnafRepository rcnafRepository;

  RcnafBloc(this.rcnafRepository) : super(RcnafInitial()) {
    on<AddRcnafEvent>(_onAddRcnaf);
    on<LoadRcnafEvent>(_onLoadRcnaf);
    on<DeleteRcnafEvent>(_onDeleteRcnaf);
  }

  Future<void> _onAddRcnaf(
      AddRcnafEvent event, Emitter<RcnafState> emit) async {
    emit(RcnafLoading());
    try {
      await rcnafRepository.insertRcnaf(event.nutrientCounts);
      emit(RcnafAdded());
    } catch (e) {
      emit(RcnafError('Failed to add Rcnaf: $e'));
    }
  }

  Future<void> _onLoadRcnaf(
      LoadRcnafEvent event, Emitter<RcnafState> emit) async {
    emit(RcnafLoading());
    try {
      final rcnafs = await rcnafRepository.getAllRcnafs();
      print('Loaded Rcnafs: ${rcnafs.length}'); // Debug print
      emit(RcnafLoaded(rcnafs));
    } catch (e) {
      emit(RcnafError('Failed to load Rcnafs: $e'));
    }
  }

  Future<void> _onDeleteRcnaf(
      DeleteRcnafEvent event, Emitter<RcnafState> emit) async {
    try {
      final dateNow = DateFormatUtil.formatDateToYYYYMMDD(DateTime.now());

      await rcnafRepository.deleteRcnaf(dateNow, event.idRacikan);
    } catch (e) {
      emit(RcnafError('Failed to load Rcnafs: $e'));
    }
  }
}
