import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrient_per_fertilizer_entity.dart';

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
