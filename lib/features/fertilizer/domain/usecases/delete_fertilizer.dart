import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnpf/rcnpf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnpf/rcnpf_event.dart';

Future<void> deleteFertilizer(BuildContext context, String idRacikan) async {
  var logger = Logger();

  context.read<FertilizerBloc>().add(DeleteFertilizerEvent(idRacikan: idRacikan));

  await Future.delayed(
      const Duration(milliseconds: 300)); // beri waktu DB selesai

  context.read<RcnpfBloc>().add(DeleteRcnpfEvent(idRacikan: idRacikan));

  await Future.delayed(const Duration(milliseconds: 300));

  context.read<RcnafBloc>().add(DeleteRcnafEvent(idRacikan: idRacikan));

  logger.i("Data Fertilizer dihapus!");
}
