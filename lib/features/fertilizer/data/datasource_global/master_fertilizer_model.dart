

import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/master_fertilizer_entity.dart';

class MasterFertilizerModel extends MasterFertilizerEntity {
  MasterFertilizerModel({
    required String manufacturer,
    required String name,
    required List<NutrientContent> nutrientContents,
  }) : super(manufacturer: manufacturer, name: name, nutrientContents: nutrientContents);

  factory MasterFertilizerModel.fromJson(Map<String, dynamic> json) {
    var list = json['nutrient_contents'] as List<dynamic>;
    List<NutrientContent> nutrientList =
        list.map((item) => NutrientContent.fromJson(item)).toList();

    return MasterFertilizerModel(
      manufacturer: json['manufacturer'] as String,
      name: json['name'] as String,
      nutrientContents: nutrientList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manufacturer': manufacturer,
      'name': name,
      'nutrient_contents':
          nutrientContents.map((n) => n.toJson()).toList(),
    };
  }
  
}

extension IterableX<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}


