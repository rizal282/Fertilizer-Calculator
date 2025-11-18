import 'package:akurasipupuk/features/fertilizer/data/datasource_global/master_fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/weight/fertilizer_name_dropdown.dart';
import 'package:flutter/material.dart';

class FertilizerWeightForm extends StatelessWidget {
  final int index;
  final FertilizerWeightInput fertilizerWeightInput;
  final List<MasterFertilizerModel> listMasterFertilizer;
  final VoidCallback? onDelete;
  final List<FocusNode> focusNodes;

  const FertilizerWeightForm(
      {super.key,
      required this.index,
      required this.fertilizerWeightInput,
      this.onDelete,
      required this.listMasterFertilizer,
      required this.focusNodes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pupuk ${index + 1}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        FertilizerNameDropdown(
            controller: fertilizerWeightInput.dropdownNamaPupukCtrl,
            masterFertilizers: listMasterFertilizer,
            onChanged: (value) {
              if (value != null) {
                fertilizerWeightInput.fertilizerNameSelected = value.name;
                // fertilizerWeightInput.manufacturerName.text = value.manufacturer;

                for (var element in value.nutrientContents) {
                    final nutrientName = element.nutrientName;

                    print("NAMA UNSUR ===>>> $nutrientName");

                    fertilizerWeightInput.nutrients[nutrientName]!.text =
                        element.valueInPercent.toString();
                  }
              }
            }),

        SizedBox(
          height: 12,
        ),

        TextFormField(
          focusNode: focusNodes[index],
          controller: fertilizerWeightInput.weightGramInput,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukan Berat (gram)',
          ),
          onFieldSubmitted: (value) {
            if (index + 1 < focusNodes.length) {
              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            } else {
              // Jika sudah terakhir -> sembunyikan keyboard
              focusNodes[index].unfocus();
            }
          },
        ),

        SizedBox(
          height: 12,
        ),
        // ExpansionTile(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        //   collapsedShape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        //   title: const Text(
        //     "Jumlah Kandungan Unsur Hara (%)",
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //   ),
        //   children: [
        //     Column(
        //       children: [
        //         for (final item in fertilizerWeightInput.nutrients.entries) ...[
        //           SizedBox(
        //             height: 10,
        //           ),
        //           TextFormField(
        //             enabled: false,
        //             keyboardType:
        //                 const TextInputType.numberWithOptions(decimal: true),
        //             controller: item.value,
        //             decoration: InputDecoration(
        //               border: const OutlineInputBorder(),
        //               labelText: 'Jumlah ${item.key} (Persen)',
        //             ),
        //           ),
        //           const SizedBox(height: 9),
        //         ]
        //       ],
        //     )
        //   ],
        // ),
      ],
    );
  }
}
