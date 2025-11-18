import 'package:akurasipupuk/features/fertilizer/data/weight/response/weight_each_fertilizer_mix_response.dart';

abstract class CountWeightByPercentState {}

class CountWeightByPercentInitial extends CountWeightByPercentState {}

class CountWeightByPercentLoading extends CountWeightByPercentState {}

class CountWeightByPercentLoaded extends CountWeightByPercentState {
  final List<WeightEachFertilizerMixResponse> response;

  CountWeightByPercentLoaded(this.response);
}

class CountWeightByPercentError extends CountWeightByPercentState {

  final String message;

  CountWeightByPercentError(this.message);
}