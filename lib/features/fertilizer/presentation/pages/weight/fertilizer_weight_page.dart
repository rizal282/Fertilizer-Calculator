import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/utils/clear_form_fertilizer.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/usecase/save_count_weight_by_target_percent.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/master_fertilizer_weight/master_fertilizer_weight_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/master_fertilizer_weight/master_fertilizer_weight_event.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/master_fertilizer_weight/master_fertilizer_weight_state.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/weight/fertilizer_weight_result_detail_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/weight/fertilizer_weight_form.dart';
import 'package:akurasipupuk/features/home/presentation/widget/button_constraint_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FertilizerWeightPage extends StatefulWidget {
  const FertilizerWeightPage({super.key});

  @override
  State<FertilizerWeightPage> createState() => _FertilizerWeightPageState();
}

class _FertilizerWeightPageState extends State<FertilizerWeightPage> {
  List<FertilizerWeightInput> fertilizerWeightInputs = [
    FertilizerWeightInput(),
    FertilizerWeightInput()
  ];

  List<FocusNode> focusNodes = [FocusNode(), FocusNode()];
  Map<String, FocusNode> targetPercentFocusNodes = {};

  final fertilizerTargetInput = FertilizerTargetInput();
  // final targetWeightMix = TextEditingController();

  @override
  void initState() {
    super.initState();

    for (final key in fertilizerTargetInput.nutrientsTargetPercent.keys) {
      targetPercentFocusNodes[key] = FocusNode();
    }

    context
        .read<MasterFertilizerWeightBloc>()
        .add(LoadMasterFertilizersEvent());
  }

  @override
  void dispose() {
    for (final node in targetPercentFocusNodes.values) {
      node.dispose();
    }

    for (var element in fertilizerWeightInputs) {
      element.manufacturerName.dispose();
      element.weightGramInput.dispose();

      element.nutrients.forEach((key, value) {
        element.nutrients[key]!.dispose();
      },);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConst.fertilizerWeightTitle,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        body: BlocBuilder<MasterFertilizerWeightBloc,
            MasterFertilizerWeightState>(
          builder: (context, state) {
            if (state is MasterFertilizerWeightLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MasterFertilizerWeightLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0;
                          i < fertilizerWeightInputs.length;
                          i++) ...[
                        FertilizerWeightForm(
                          index: i,
                          fertilizerWeightInput: fertilizerWeightInputs[i],
                          listMasterFertilizer: state.masterFertilizer,
                          onDelete: i >= 2
                              ? () => setState(() {
                                    fertilizerWeightInputs.removeAt(i);
                                    focusNodes.removeAt(i);
                                  })
                              : null,
                          focusNodes: focusNodes,
                        )
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonConstraintBox(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                clearFormFertilizerWeight(
                                    fertilizerWeightInputs,
                                    fertilizerTargetInput);
                              },
                              icon: const Icon(
                                Icons.restore,
                                color: Colors.white,
                              ),
                              label:
                                  const Text(StringConst.resetFormBtnLabel),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          ButtonConstraintBox(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  fertilizerWeightInputs
                                      .add(FertilizerWeightInput());
                                  focusNodes.add(FocusNode());
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: const Text(
                                  StringConst.addFertilizerBtnLabel),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        title: const Text(
                          "Masukkan Target Unsur Hara (%)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        children: [
                          Column(
                            children: [
                              for (final item in fertilizerTargetInput
                                  .nutrientsTargetPercent.entries) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  focusNode: targetPercentFocusNodes[item.key],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  controller: item.value,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: 'Jumlah ${item.key} (Persen)',
                                  ),
                                  onFieldSubmitted: (_) {
                                    final keys = fertilizerTargetInput
                                        .nutrientsTargetPercent.keys
                                        .toList();
                                    final currentIndex = keys.indexOf(item.key);

                                    if (currentIndex + 1 < keys.length) {
                                      targetPercentFocusNodes[
                                              keys[currentIndex + 1]]!
                                          .requestFocus();
                                    }
                                  },
                                ),
                                const SizedBox(height: 9),
                              ]
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // TextFormField(
                      //   keyboardType: const TextInputType.numberWithOptions(
                      //       decimal: true),
                      //   controller: targetWeightMix,
                      //   decoration: const InputDecoration(
                      //     border: OutlineInputBorder(),
                      //     labelText: 'Masukkan Jumlah Berat Campuran (g)',
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 12,
                      // ),

                      SizedBox(
                        width: double.infinity,
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

                            if (confirmSave == true) {
                              saveCountWeightByTargetPercent(
                                      context,
                                      fertilizerTargetInput,
                                      fertilizerWeightInputs)
                                  .then((success) {
                                if (!success) return;

                                clearFormFertilizerWeight(
                                  fertilizerWeightInputs,
                                  fertilizerTargetInput,
                                );

                                context
                                    .read<CountWeightByPercentBloc>()
                                    .add(LoadCountWeightByPercentEvent());

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: context
                                              .read<CountWeightByPercentBloc>(),
                                          child:
                                              const FertilizerWeightResultDetailPage(),
                                        )));
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Hitung!",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is MasterFertilizerWeightError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
