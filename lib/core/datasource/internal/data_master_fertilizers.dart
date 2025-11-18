import 'dart:convert';

import 'package:akurasipupuk/features/fertilizer/data/datasource_global/master_fertilizer_model.dart';
import 'package:flutter/services.dart';

Future<List<MasterFertilizerModel>> loadDataMasterFertilizers() async {

  List<MasterFertilizerModel> masterFertilizers = [];

  String jsonFertilizersString = await rootBundle.loadString('assets/json/master_data_fertilizers.json');

  final jsonData = json.decode(jsonFertilizersString)['data']['fertilizers'] as List<dynamic>;

  for(int i = 0; i < jsonData.length; i++){
    final responseFertilizer = MasterFertilizerModel.fromJson(jsonData[i]);

    masterFertilizers.add(responseFertilizer);
  }

  // Urutkan berdasarkan nama (ascending, A-Z)
  masterFertilizers.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  print("MASTER DATA FERTILIZER =============>> ${masterFertilizers.length}");

  return masterFertilizers;
}