import 'package:akurasipupuk/core/constants/ppm_options_const.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/usecase/ppm_usecase.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_state.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/hasil_hitung_konsentrasi_ppm.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/hasil_hitung_massa_zat_terlarut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PpmResultCountPage extends StatefulWidget {
  int? countType;
  PpmResultCountPage({super.key, this.countType});

  @override
  State<PpmResultCountPage> createState() => _PpmResultCountPageState();
}

class _PpmResultCountPageState extends State<PpmResultCountPage> {
  PpmType? selectedValuePpm;

  @override
  void initState() {
    super.initState();
    context.read<PpmBloc>().add(LoadCountResultFromPPMFormEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hasil Hitung',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PpmBloc, PpmState>(
            builder: (context, state) {
              if (state is CountResultFromPPMFormLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CountResultFromPPMFormLoaded) {
                final itemCountPpms = state.dataCountResult;

                if (itemCountPpms.isEmpty) {
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
                        Text("Tidak ada data"),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: itemCountPpms.length,
                  itemBuilder: (context, i) {
                    final itemCount = itemCountPpms[i];

                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF3C8D40)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (itemCount.countType == '1') ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Hasil hitung nilai PPM:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    IconButton(
                                        onPressed: () async {
                                          await PpmUsecase.deletePPMCountByID(
                                              context, itemCount.id!);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total PPM"),
                                    Text(
                                      "${itemCount.totalPpm!.toStringAsFixed(2).replaceAll(".", ",")} mg/L",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Massa pupuk dimasukkan"),
                                    Text(
                                        "${itemCount.totalMassOfSolute.toString().replaceAll(".", ",")} g"),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Volume larutan dimasukkan"),
                                    Text(
                                        "${itemCount.totalSolutionVolume.toString().replaceAll(".", ",")} L"),
                                  ],
                                )
                              ],
                              if (itemCount.countType == '2') ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Hasil hitung massa pupuk terlarut:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    IconButton(
                                        onPressed: () async {
                                          await PpmUsecase.deletePPMCountByID(
                                              context, itemCount.id!);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total pupuk terlarut"),
                                    Text(
                                      "${itemCount.totalMassOfSolute.toString().replaceAll(".", ",")} g",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("PPM yang dimasukkan"),
                                    Text(
                                        "${itemCount.totalPpm.toString().replaceAll(".", ",")} mg/L"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Volume larutan dimasukkan"),
                                    Text(
                                        "${itemCount.totalSolutionVolume.toString().replaceAll(".", ",")} L"),
                                  ],
                                )
                              ],
                              if (itemCount.countType == '3') ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Hasil hitung volume larutan:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    IconButton(
                                        onPressed: () async {
                                          await PpmUsecase.deletePPMCountByID(
                                              context, itemCount.id!);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total volume larutan"),
                                    Text(
                                      "${itemCount.totalSolutionVolume!.toStringAsFixed(2).replaceAll(".", ",")} L",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Massa pupuk dimasukkan"),
                                    Text(
                                        "${itemCount.totalMassOfSolute.toString().replaceAll(".", ",")} g"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("PPM yang dimasukkan"),
                                    Text(
                                        "${itemCount.totalPpm.toString().replaceAll(".", ",")} mg/L"),
                                  ],
                                ),
                              ]
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
                    Text("Tidak Ada Data"),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                DropdownButtonFormField<PpmType>(
//               decoration: InputDecoration(
//                 labelText: 'Pilih Perhitungan',
//                 border: OutlineInputBorder(),
//               ),
//               value: selectedValuePpm,
//               items: PpmOptionsConst.ppmOptions.map((item) {
//                 return DropdownMenuItem<PpmType>(
//                   value: item,
//                   child: Text(item.itemName),
//                 );
//               }).toList(),
//               onChanged: (value) async {
//                 setState(() {
//                   selectedValuePpm = value;
//                   widget.countType = value!.itemId;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 12,
//             ),

//               if(widget.countType == 1) ...[
//                 Text("Hasil Hitung PPM"),
//                 SizedBox(height: 12,),
//                 Expanded(child: HasilHitungKonsentrasiPpm()),
//               ],

//               if(widget.countType == 2) ...[
//                 Text("Hasil Hitung Massa Zat Terlarut"),
//                 SizedBox(height: 12,),
//                 Expanded(child: HasilHitungMassaZatTerlarut()),
//               ],

//               if(widget.countType == 3) ...[
//                 Text("Hasil Hitung Volume Larutan"),
//                 SizedBox(height: 12,),
//                 Expanded(child: Text("Volume Larutan")),
//               ],
//             ],
//           )
