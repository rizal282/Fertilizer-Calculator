import 'package:flutter/material.dart';

class FertilizerInput {
  final TextEditingController namaPupukController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
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
