import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrients_all_fertilizers_entity.dart';

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