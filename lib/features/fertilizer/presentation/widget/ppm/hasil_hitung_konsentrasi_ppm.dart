import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HasilHitungKonsentrasiPpm extends StatefulWidget {
  const HasilHitungKonsentrasiPpm({super.key});

  @override
  State<HasilHitungKonsentrasiPpm> createState() =>
      _HasilHitungKonsentrasiPpmState();
}

class _HasilHitungKonsentrasiPpmState extends State<HasilHitungKonsentrasiPpm> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<PpmBloc>().add(LoadCountResultFromPPMFormEvent());
    // });

    context.read<PpmBloc>().add(LoadCountResultFromPPMFormEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PpmBloc, PpmState>(
          builder: (context, state) {
            if (state is CountResultFromPPMFormLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CountResultFromPPMFormLoaded) {
              if (state.dataCountResult.isEmpty) {
                return Center(
                  child: Text("Tidak ada data perhitungan PPM"),
                );
              }
        
              return ListView.builder(
                itemCount: state.dataCountResult.length,
                itemBuilder: (context, i) {
                  final data = state.dataCountResult[i];
        
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF3C8D40)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Konsentrasi PPM:"),
                                Text(
                                  "${data.totalPpm!.toStringAsFixed(3)} mg/L",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Massa Pupuk:"),
                                Text(
                                  "${data.totalMassOfSolute} g",
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Volume Larutan:"),
                                Text(
                                  "${data.totalSolutionVolume} L",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  );
                },
              );
            }
        
            return Text("Tidak ada data");
          },
        ),
      ),
    );
  }
}
