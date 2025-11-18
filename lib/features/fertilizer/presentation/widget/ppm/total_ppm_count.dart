import 'package:akurasipupuk/core/constants/ppm_options_const.dart';
import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/usecase/ppm_usecase.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPpmCount extends StatefulWidget {
  final String idRacikan;
  final double weightFertilizerMix;

  TotalPpmCount(
      {super.key,
      required this.idRacikan,
      required this.weightFertilizerMix,});

  @override
  State<TotalPpmCount> createState() => _TotalPpmCountState();
}

class _TotalPpmCountState extends State<TotalPpmCount> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white
      ),
      onPressed: () {
      showDialog(
            context: context,
            builder: (context) {
              TextEditingController inputVolumeLarutanCtrl =
                  TextEditingController();

              return AlertDialog(
                title: Text(
                  "Input Volume Larutan (L)",
                  style: TextStyle(fontSize: 16),
                ),
                content: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: inputVolumeLarutanCtrl,
                  decoration: InputDecoration(
                    labelText: "Masukkan nilai",
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Batal"),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (inputVolumeLarutanCtrl.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Volume larutan harus diisi!")),
                        );
                        return;
                      }

                      await PpmUsecase.countPpmConcentrate(context,
                          idRacikan: widget.idRacikan,
                          volumeLarutan: inputVolumeLarutanCtrl.text,
                          weightFertilizerMix: widget.weightFertilizerMix,
                          sourcePpm: StringConst.sourcePpmFromResultPage
                      );

                      context
                          .read<CountWeightByPercentBloc>()
                          .add(LoadCountWeightByPercentEvent());

                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
    }, child: Text("Hitung PPM", style: TextStyle(color: Color(0xFF3C8D40)),));
  }
}
