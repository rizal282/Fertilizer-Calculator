import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HasilHitungMassaZatTerlarut extends StatefulWidget {
  const HasilHitungMassaZatTerlarut({super.key});

  @override
  State<HasilHitungMassaZatTerlarut> createState() => _HasilHitungMassaZatTerlarutState();
}

class _HasilHitungMassaZatTerlarutState extends State<HasilHitungMassaZatTerlarut> {

  @override
  void initState() {
    
    context.read<PpmBloc>().add(LoadHasiHitungMassaZatTerlarutEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<PpmBloc, PpmState>(
          builder: (context, state) {
            if(state is CountResultMassaZatTerlarutLoading) return Center(child: CircularProgressIndicator(),);

            if(state is CountResultMassaZatTerlarutLoaded) {
              ListView.builder(
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
                                Text("Massa Pupuk Terlarut:"),
                                Text(
                                  "${data.totalMassOfSolute} g",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Konsentrasi PPM:"),
                                Text(
                                  "${data.totalPpm!.toStringAsFixed(3)} mg/L",
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

            return Center(child: Text("Tidak Ada Data"));
          },
        ),
      ),
    );
  }
}