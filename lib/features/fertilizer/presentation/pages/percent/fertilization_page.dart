import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/core/utils/action_back_alert.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/usecases/save_fertilizer.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/utils/clear_form_fertilizer.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/fertilizer/fertilizer_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/fertilizer/fertilizer_state.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/percent/fertilizer_input.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/percent/fertilizer_calculate_result_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/percent/fertilizer_form.dart';
import 'package:akurasipupuk/features/home/presentation/widget/button_constraint_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FertilizationPage extends StatefulWidget {
  const FertilizationPage({super.key});

  @override
  State<FertilizationPage> createState() => _FertilizationPageState();
}

class _FertilizationPageState extends State<FertilizationPage> {
  List<FertilizerInput> fertilizers = [
    FertilizerInput(),
    FertilizerInput(),
  ];

  List<FocusNode> fertNameFocusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  List<FocusNode> fertWeightFocusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void dispose() {
    for (final item in fertilizers) {
      item.namaPupukController.dispose();
      item.weightController.dispose();

      item.nutrients.forEach(
        (key, value) {
          item.nutrients[key]!.dispose();
        },
      );
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final bool shouldPop = await onWillPop(context);

        if (shouldPop) {
          clearFormFertilizer(fertilizers);
          Navigator.of(context).pop();
        }
      },
      child: BlocConsumer<FertilizerBloc, FertilizerState>(
        listener: (context, state) {
          if (state is FertilizerLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Data berhasil disimpan")),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  StringConst.fertilizerPageTitle,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < fertilizers.length; i++) ...[
                        FertilizerForm(
                          index: i,
                          fertilizer: fertilizers[i],
                          onDelete: i >= 2
                              ? () => setState(() {
                                    fertilizers.removeAt(i);
                                    fertNameFocusNodes.removeAt(i);
                                    fertWeightFocusNodes.removeAt(i);
                                  })
                              : null,
                          fertNameFocusNodes: fertNameFocusNodes,
                          fertWeightFocusNodes: fertWeightFocusNodes,
                        ),
                        const SizedBox(height: 18),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonConstraintBox(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                clearFormFertilizer(fertilizers);
                              },
                              icon: const Icon(
                                Icons.restore,
                                color: Colors.white,
                              ),
                              label: const Text(StringConst.resetFormBtnLabel),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          ButtonConstraintBox(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  fertilizers.add(FertilizerInput());
                                  fertNameFocusNodes.add(FocusNode());
                                  fertWeightFocusNodes.add(FocusNode());
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label:
                                  const Text(StringConst.addFertilizerBtnLabel),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            final bool? confirmSave = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Konfirmasi'),
                                  content: const Text(
                                      'Apakah Anda yakin ingin menghitung data ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pop(false), // batal
                                      child: const Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.of(context)
                                          .pop(true), // konfirmasi hapus
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.lightGreen,
                                      ),
                                      child: const Text(
                                        'Hitung',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            // Jika pengguna menekan "Hapus"
                            if (confirmSave == true) {
                              saveDataFertilizer(context, fertilizers)
                                  .then((success) {
                                if (!success) return;

                                clearFormFertilizer(fertilizers);

                                // trigger bloc reload kalau belum dilakukan di dalam fungsi
                                context.read<RcnafBloc>().add(LoadRcnafEvent());

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: context.read<RcnafBloc>(),
                                      child:
                                          const FertilizerCalculateResultPage(),
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            StringConst.saveFertilizerBtnLabel,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
