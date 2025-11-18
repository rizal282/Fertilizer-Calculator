import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/utils/decimal_formatter.dart';
import 'package:akurasipupuk/core/utils/unique_id_racikan_generator.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/usecase/ppm_usecase.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/ppm/ppm_result_count_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/hasil_hitung_konsentrasi_ppm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PpmFormCount extends StatefulWidget {
  final int countType;
  const PpmFormCount({super.key, required this.countType});

  @override
  State<PpmFormCount> createState() => _PpmFormCountState();
}

class _PpmFormCountState extends State<PpmFormCount> {
  final TextEditingController massaPupukGramCtrl = TextEditingController();
  final TextEditingController volumeLarutanCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: massaPupukGramCtrl,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukkan Massa Pupuk (g)',
          ),
        ),
        SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: volumeLarutanCtrl,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukkan Volume Larutan (L)',
          ),
        ),
        SizedBox(
          height: 12,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () async {
                final volumeLarutan = volumeLarutanCtrl.text;
                final massaPupukGram = massaPupukGramCtrl.text;

                if (volumeLarutan.isEmpty && massaPupukGram.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Masukkan Massa Pupuk dan Volume Larutan")),
                  );

                  return;
                }

                final String idRacikan = uniqueIdRacikanGenerator();

                final double? massaPupukGramParse = double.tryParse(
                    decimalTextContainsCommaFormatter(massaPupukGram));

                PpmUsecase.countPpmConcentrate(context,
                        idRacikan: idRacikan,
                        volumeLarutan: volumeLarutan,
                        weightFertilizerMix: massaPupukGramParse!,
                        sourcePpm: StringConst.sourcePpmFromCountPPMForm)
                    .then(
                  (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data PPM berhasil disimpan")),
                    );

                    context
                        .read<PpmBloc>()
                        .add(LoadCountResultFromPPMFormEvent());

                    volumeLarutanCtrl.clear();
                    massaPupukGramCtrl.clear();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: context.read<PpmBloc>(),
                          child: PpmResultCountPage(),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text("Hitung!")),
        )
      ],
    );
  }
}
