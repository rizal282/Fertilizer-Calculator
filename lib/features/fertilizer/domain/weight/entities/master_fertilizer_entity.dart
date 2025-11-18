class MasterFertilizerEntity {
  final String manufacturer;
  final String name;
  final List<NutrientContent> nutrientContents;

  MasterFertilizerEntity({
    required this.manufacturer,
    required this.name,
    required this.nutrientContents,
  });

  
}

class NutrientContent {
  final String symbol;
  final String nutrientName;
  final double valueInPercent;

  NutrientContent({
    required this.symbol,
    required this.nutrientName,
    required this.valueInPercent,
  });

  factory NutrientContent.fromJson(Map<String, dynamic> json) {
    return NutrientContent(
      symbol: json['symbol'] as String,
      nutrientName: json['nutrient_name'] as String,
      valueInPercent: (json['value_in_percent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'nutrient_name': nutrientName,
      'value_in_percent': valueInPercent,
    };
  }
}