import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/utils/unique_id_racikan_generator.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/usecase/ppm_usecase.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/ppm/ppm_result_count_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/hasil_hitung_volume_larutan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolumeLarutanCountForm extends StatefulWidget {
  final int? countType;
  const VolumeLarutanCountForm({super.key, required this.countType});

  @override
  State<VolumeLarutanCountForm> createState() => _VolumeLarutanCountFormState();
}

class _VolumeLarutanCountFormState extends State<VolumeLarutanCountForm> {
  final TextEditingController massaZatTerlarutCtrl = TextEditingController();
  final TextEditingController nilaiKonsentrasiPPMCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: massaZatTerlarutCtrl,
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
          controller: nilaiKonsentrasiPPMCtrl,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukkan Konsentrasi Pupuk (ppm)',
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

                if (massaZatTerlarutCtrl.text.isEmpty &&
                    nilaiKonsentrasiPPMCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Data belum diinput!")),
                  );

                  return;
                }

                await PpmUsecase.countVolumeLarutan(
                        context: context,
                        idRacikan: idRacikan,
                        sourcePpm: StringConst.sourcePpmFromCountPPMForm,
                        massaZatTerlarut: massaZatTerlarutCtrl.text,
                        nilaiKonsetrasiPpm: nilaiKonsentrasiPPMCtrl.text)
                    .then(
                  (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data Volume Larutan disimpan")),
                    );

                    massaZatTerlarutCtrl.clear();
                    nilaiKonsentrasiPPMCtrl.clear();

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
