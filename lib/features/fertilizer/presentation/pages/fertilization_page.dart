import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfg_app/core/constants/string_const.dart';
import 'package:pfg_app/features/fertilizer/domain/usecases/save_fertilizer.dart';
import 'package:pfg_app/features/fertilizer/domain/utils/clear_form_fertilizer.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_state.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_event.dart';
import 'package:pfg_app/features/fertilizer/presentation/model/fertilizer_input.dart';
import 'package:pfg_app/features/fertilizer/presentation/pages/fertilizer_calculate_result_page.dart';
import 'package:pfg_app/features/fertilizer/presentation/widget/fertilizer_form.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FertilizerBloc, FertilizerState>(
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
                StringConst.FERTILIZER_PAGE_TITLE,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              backgroundColor: Colors.blueAccent,
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
                            ? () => setState(() => fertilizers.removeAt(i))
                            : null,
                      ),
                      const SizedBox(height: 18),
                    ],
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            fertilizers.add(FertilizerInput());
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(StringConst.ADD_FERTILIZER_BTN_LABEL),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          saveDataFertilizer(context, fertilizers).then((success) {

                            if (!success) return;

                            clearFormFertilizer(fertilizers);

                            // trigger bloc reload kalau belum dilakukan di dalam fungsi
                            context.read<RcnafBloc>().add(LoadRcnafEvent());

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<RcnafBloc>(),
                                  child: const FertilizerCalculateResultPage(),
                                ),
                              ),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          StringConst.SAVE_FERTILIZER_BTN_LABEL,
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
    );
  }
}
