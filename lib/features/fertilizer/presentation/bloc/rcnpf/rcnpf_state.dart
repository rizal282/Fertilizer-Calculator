import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrient_per_fertilizer_entity.dart';

abstract class RcnpfState {}

class RcnpfInitial extends RcnpfState {}

class RcnpfLoading extends RcnpfState {}

class RcnpfLoaded extends RcnpfState {
  final List<ResultCountNutrientPerFertilizerEntity> listRcnpf;

  RcnpfLoaded(this.listRcnpf);
}

class RcnpfAdded extends RcnpfState {}

class RcnpfError extends RcnpfState {
  final String message;

  RcnpfError(this.message);
}
