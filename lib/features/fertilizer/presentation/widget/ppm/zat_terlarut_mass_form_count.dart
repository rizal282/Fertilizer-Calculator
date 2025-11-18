import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/utils/unique_id_racikan_generator.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/usecase/ppm_usecase.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/ppm/ppm_result_count_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/hasil_hitung_massa_zat_terlarut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZatTerlarutMassFormCount extends StatefulWidget {
  final int? countType;
  const ZatTerlarutMassFormCount({super.key, required this.countType});

  @override
  State<ZatTerlarutMassFormCount> createState() =>
      _ZatTerlarutMassFormCountState();
}

class _ZatTerlarutMassFormCountState extends State<ZatTerlarutMassFormCount> {
  final TextEditingController nilaiPPMCtrl = TextEditingController();
  final TextEditingController volumeLarutanCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: nilaiPPMCtrl,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukkan Nilai PPM (mg/L)',
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
                final idRacikan = uniqueIdRacikanGenerator();

                if (nilaiPPMCtrl.text.isEmpty &&
                    volumeLarutanCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Data belum diinput!")),
                  );

                  return;
                }

                PpmUsecase.countMassaZatTerlarut(
                        context: context,
                        idRacikan: idRacikan,
                        sourcePpm: StringConst.sourcePpmFromCountPPMForm,
                        volumeLarutan: volumeLarutanCtrl.text,
                        nilaiPpm:  nilaiPPMCtrl.text)
                    .then(
                  (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Data Massa Zat Terlarut disimpan")),
                    );

                    volumeLarutanCtrl.clear();
                    nilaiPPMCtrl.clear();

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
