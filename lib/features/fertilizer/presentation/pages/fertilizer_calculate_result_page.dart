import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_state.dart';
import 'package:pfg_app/features/fertilizer/presentation/widget/item_result_count_fertilizers.dart';

class FertilizerCalculateResultPage extends StatefulWidget {
  const FertilizerCalculateResultPage({super.key});

  @override
  State<FertilizerCalculateResultPage> createState() =>
      _FertilizerCalculateResultState();
}

class _FertilizerCalculateResultState
    extends State<FertilizerCalculateResultPage> {
  @override
  void initState() {
    super.initState();
    context.read<RcnafBloc>().add(LoadRcnafEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Kalau sudah ada RcnafBloc dari atas, tidak perlu BlocProvider di sini
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "Hasil Grade Fertilizer Campuran",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<RcnafBloc, RcnafState>(
            builder: (context, state) {
              if (state is RcnafLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RcnafLoaded) {
                final rcnafs = state.listRcnaf;
                return ListView.builder(
                  itemCount: rcnafs.length,
                  itemBuilder: (context, index) {
                    final rcnaf = rcnafs[index];
                    return ItemResultCountFertilizers(rcnaf: rcnaf, index: index,);
                  },
                );
              } else if (state is RcnafError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No data available'));
            },
          ),
        ),
      ),
    );
  }
}


