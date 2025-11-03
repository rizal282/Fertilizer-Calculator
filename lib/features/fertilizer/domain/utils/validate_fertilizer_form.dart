import 'package:flutter/material.dart';
import 'package:pfg_app/features/fertilizer/presentation/model/fertilizer_input.dart';

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
