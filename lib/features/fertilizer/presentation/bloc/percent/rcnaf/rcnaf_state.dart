import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/result_count_nutrients_all_fertilizers_entity.dart';

abstract class RcnafState {}

class RcnafInitial extends RcnafState {}

class RcnafLoading extends RcnafState {}

class RcnafLoaded extends RcnafState {
  final List<ResultCountNutrientsAllFertilizersEntity> listRcnaf;

  RcnafLoaded(this.listRcnaf);
} 

class RcnafAdded extends RcnafState {}

class RcnafError extends RcnafState {
  final String message;

  RcnafError(this.message);
}