import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/repositories/rcnpf_repository.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnpf/rcnpf_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnpf/rcnpf_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RcnpfBloc extends Bloc<RcnpfEvent, RcnpfState> {

  final RcnpfRepository rcnpfRepository;

  RcnpfBloc(this.rcnpfRepository) : super(RcnpfInitial()) {
    on<AddRcnpfEvent>(_onAddRcnpf);
    on<DeleteRcnpfEvent>(_onDeleteRcnpf);
  } 

  Future<void> _onAddRcnpf(AddRcnpfEvent event, Emitter<RcnpfState> emit) async {
    emit(RcnpfLoading());
    try {
      await rcnpfRepository.insertRcnpf(event.entity);
      emit(RcnpfAdded());
    } catch (e) {
      emit(RcnpfError('Failed to add Rcnpf: $e'));
    }
  } 

  Future<void> _onDeleteRcnpf(DeleteRcnpfEvent event, Emitter<RcnpfState> emit) async {
    try {
      final dateNow = DateFormatUtil.formatDateToYYYYMMDD(DateTime.now());

      await rcnpfRepository.deleteRcnpf(dateNow, event.idRacikan);
    } catch (e) {
      emit(RcnpfError('Failed to load fertilizers: $e'));
    }
  }

}