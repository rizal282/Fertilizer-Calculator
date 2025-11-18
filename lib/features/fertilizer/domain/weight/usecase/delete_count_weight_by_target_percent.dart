import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

var log = Logger();

Future<void> deleteCountWeightByTargetPercent(BuildContext context, String idRacikan) async {

  context.read<CountWeightByPercentBloc>().add(DeleteCountWeightByPercentEvent(idRacikan));

  
}
