import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_state.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/weight/item_detail_count_weight_fertilizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FertilizerWeightResultDetailPage extends StatefulWidget {
  const FertilizerWeightResultDetailPage({super.key});

  @override
  State<FertilizerWeightResultDetailPage> createState() =>
      _FertilizerWeightResultDetailPageState();
}

class _FertilizerWeightResultDetailPageState
    extends State<FertilizerWeightResultDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<CountWeightByPercentBloc>()
        .add(LoadCountWeightByPercentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil Hitung Otomatis",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<CountWeightByPercentBloc, CountWeightByPercentState>(
          builder: (context, state) {
            if (state is CountWeightByPercentLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CountWeightByPercentLoaded) {
              if (state.response.isEmpty) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 70,
                        color: Color(0xFF3C8D40),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Tidak Ada Data",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.response.length,
                itemBuilder: (context, i) {
                  final itemDetail = state.response[i];
                  return Column(
                    children: [
                      ItemDetailCountWeightFertilizer(
                          weightEachFertilizerMixResponse: itemDetail),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  );
                },
              );
            } else if (state is CountWeightByPercentError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Tidak Ada Data'));
          },
        ),
      ),
    );
  }
}
