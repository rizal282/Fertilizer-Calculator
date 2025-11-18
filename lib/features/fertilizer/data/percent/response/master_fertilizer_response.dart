

import 'package:akurasipupuk/features/fertilizer/data/datasource_global/master_fertilizer_model.dart';

class MasterFertilizerResponse {
  final List<MasterFertilizerModel> fertilizers;

  MasterFertilizerResponse({required this.fertilizers});

  factory MasterFertilizerResponse.fromJson(Map<String, dynamic> json) {
    var list = json['fertilizers'] as List<dynamic>;
    List<MasterFertilizerModel> fertilizersList =
        list.map((item) => MasterFertilizerModel.fromJson(item)).toList();

    return MasterFertilizerResponse(fertilizers: fertilizersList);
  }

  Map<String, dynamic> toJson() {
    return {
      'fertilizers': fertilizers.map((f) => f.toJson()).toList(),
    };
  }
}
