import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_state.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/percent/item_result_count_fertilizers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          title: const Text(
            "Hasil Hitung Manual",
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

                if(rcnafs.isEmpty){
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, size: 70, color: Color(0xFF3C8D40),),
                        SizedBox(height: 12,),
                        Text("Tidak Ada Data", style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  );
                }

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


