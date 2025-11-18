import 'package:flutter/material.dart';


// untuk setiap pupuk yang dipilih
class FertilizerWeightInput {
  
  String? fertilizerNameSelected;
  final TextEditingController manufacturerName = TextEditingController();
  final TextEditingController weightGramInput = TextEditingController();
  final dropdownNamaPupukCtrl = FertilizerDropdownController();

  final Map<String, TextEditingController> nutrients = {
    'Nitrogen': TextEditingController(),
    'Posfor': TextEditingController(),
    'Kalium': TextEditingController(),
    'Boron': TextEditingController(),
    'Tembaga': TextEditingController(),
    'Besi': TextEditingController(),
    'Magnesium': TextEditingController(),
    'Mangan': TextEditingController(),
    'Molibdenum': TextEditingController(),
    'Seng': TextEditingController(),
    'Kalsium': TextEditingController(),
    'Sulfur': TextEditingController(),
  };

}

class FertilizerDropdownController {
  void Function()? reset;
}


// untuk target persen kadar unsur pupuk setelah dicampur
class FertilizerTargetInput {
  final Map<String, TextEditingController> nutrientsTargetPercent = {
    'Nitrogen': TextEditingController(),
    'Posfor': TextEditingController(),
    'Kalium': TextEditingController(),
    'Kalsium': TextEditingController(),
    'Sulfur': TextEditingController(),
    'Magnesium': TextEditingController(),
  };
}