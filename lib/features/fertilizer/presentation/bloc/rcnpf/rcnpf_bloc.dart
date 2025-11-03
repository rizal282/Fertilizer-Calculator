import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfg_app/core/utils/date_format_util.dart';
import 'package:pfg_app/features/fertilizer/domain/repositories/rcnpf_repository.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnpf/rcnpf_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnpf/rcnpf_state.dart';

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