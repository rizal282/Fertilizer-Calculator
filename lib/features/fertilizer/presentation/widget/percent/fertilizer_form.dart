import 'package:akurasipupuk/features/fertilizer/presentation/model/percent/fertilizer_input.dart';
import 'package:flutter/material.dart';


class FertilizerForm extends StatelessWidget {
  final int index;
  final FertilizerInput fertilizer;

  final List<FocusNode> fertNameFocusNodes;
  final List<FocusNode> fertWeightFocusNodes;

  final VoidCallback? onDelete;

  const FertilizerForm({
    super.key,
    required this.index,
    required this.fertilizer,
    required this.fertNameFocusNodes,
    required this.fertWeightFocusNodes,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header + tombol hapus
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

        TextFormField(
          focusNode: fertNameFocusNodes[index],
          controller: fertilizer.namaPupukController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukkan Nama Pupuk',
          ),
          onFieldSubmitted: (value) {
            if (index + 1 < fertNameFocusNodes.length) {
              FocusScope.of(context).requestFocus(fertNameFocusNodes[index + 1]);
            } else {
              // Jika sudah terakhir -> sembunyikan keyboard
              fertNameFocusNodes[index].unfocus();
            }
          },
        ),

        const SizedBox(height: 18),

        TextFormField(
          focusNode: fertWeightFocusNodes[index],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          controller: fertilizer.weightController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukkan Jumlah Pupuk (Gram)',
          ),
          onFieldSubmitted: (value) {
            if (index + 1 < fertWeightFocusNodes.length) {
              FocusScope.of(context).requestFocus(fertWeightFocusNodes[index + 1]);
            } else {
              // Jika sudah terakhir -> sembunyikan keyboard
              fertWeightFocusNodes[index].unfocus();
            }
          },
        ),

        const SizedBox(height: 18),

        ExpansionTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          collapsedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title: const Text(
            "Jumlah Kandungan Unsur Hara (%)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  for (final item in fertilizer.nutrients.entries) ...[
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: item.value,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Masukkan Jumlah ${item.key} (Persen)',
                      ),
                    ),
                    const SizedBox(height: 9),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
