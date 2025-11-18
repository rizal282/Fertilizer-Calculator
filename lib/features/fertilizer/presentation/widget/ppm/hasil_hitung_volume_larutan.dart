import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HasilHitungVolumeLarutan extends StatefulWidget {
  const HasilHitungVolumeLarutan({super.key});

  @override
  State<HasilHitungVolumeLarutan> createState() => _HasilHitungVolumeLarutanState();
}

class _HasilHitungVolumeLarutanState extends State<HasilHitungVolumeLarutan> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PpmBloc>().add(LoadHasilHitungVolumeLarutanEvent());
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}