import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';

abstract class FertilizerState {}

class FertilizerInitial extends FertilizerState {}

class FertilizerLoading extends FertilizerState {}

class FertilizerLoaded extends FertilizerState {
  final List<FertilizerEntity> fertilizers;

  FertilizerLoaded(this.fertilizers);
}

class FertilizerError extends FertilizerState {
  final String message;

  FertilizerError(this.message);
} 

