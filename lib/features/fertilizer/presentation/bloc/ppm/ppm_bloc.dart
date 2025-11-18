import 'package:akurasipupuk/features/fertilizer/domain/ppm/repositories/ppm_repository.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PpmBloc extends Bloc<PpmEvent, PpmState> {
  final PpmRepository _ppmRepository;

  PpmBloc(this._ppmRepository) : super(CountPpmConcentrateInitial()) {
    on<SaveCountTotalPpmConcentrateEvent>(_onSaveCountTotalPpmConcentrate);
    on<LoadCountResultFromPPMFormEvent>(_onLoadCountResultFromPPMForm);
    on<LoadHasiHitungMassaZatTerlarutEvent>(_onLoadHasilHitungMassaZatTerlarut);
    on<LoadHasilHitungVolumeLarutanEvent>(_onLoadHasilHitungVolumeLarutan);
    on<DeletePPMCountByIDEvent>(_onDeletePPMCountByID);
  }

  Future<void> _onDeletePPMCountByID(DeletePPMCountByIDEvent event, Emitter<PpmState> emit) async {

    emit(CountPpmConcentrateLoading());

      _ppmRepository.deletePPMCountByID(event.id).then((_) {
        add(LoadCountResultFromPPMFormEvent());
      });

     

  }

  Future<void> _onLoadHasilHitungVolumeLarutan(
      LoadHasilHitungVolumeLarutanEvent event, Emitter<PpmState> emit) async {
    emit(CountResultVolumeLarutanLoading());

    final hasilHitungVolumeLarutan =
        await _ppmRepository.getCountHasilHitungMassaZatTerlarut();

    emit(CountResultVolumeLarutanLoaded(hasilHitungVolumeLarutan));
  }

  Future<void> _onLoadHasilHitungMassaZatTerlarut(
      LoadHasiHitungMassaZatTerlarutEvent event, Emitter<PpmState> emit) async {
    emit(CountResultMassaZatTerlarutLoading());

    final dataMassaZatTerlarut =
        await _ppmRepository.getCountHasilHitungMassaZatTerlarut();

    emit(CountResultMassaZatTerlarutLoaded(dataMassaZatTerlarut));
  }

  Future<void> _onSaveCountTotalPpmConcentrate(
      SaveCountTotalPpmConcentrateEvent event, Emitter<PpmState> emit) async {
    emit(CountPpmConcentrateLoading());

    _ppmRepository
        .saveCountPpmConcentrate(event.ppmSolutionConcentrationEntity)
        .then(
      (_) {
        add(LoadCountResultFromPPMFormEvent());
      },
    );
  }

  Future<void> _onLoadCountResultFromPPMForm(
      LoadCountResultFromPPMFormEvent event, Emitter<PpmState> emit) async {
    emit(CountResultFromPPMFormLoading());

    final countResultFromPPMForm = await _ppmRepository.getCountFromPPMForm();

    emit(CountResultFromPPMFormLoaded(countResultFromPPMForm));
  }
}
