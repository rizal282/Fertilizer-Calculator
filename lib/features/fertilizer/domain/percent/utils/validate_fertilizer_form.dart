import 'package:akurasipupuk/features/fertilizer/presentation/model/percent/fertilizer_input.dart';
import 'package:flutter/material.dart';

bool isFertilizerFormValid(BuildContext context, FertilizerInput fertilizer) {
  if (fertilizer.namaPupukController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Nama pupuk tidak boleh kosong")),
    );
    return false;
  }

  if (fertilizer.weightController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Berat (Gram) pupuk tidak boleh kosong")),
    );
    return false;
  }

  return true;
}
