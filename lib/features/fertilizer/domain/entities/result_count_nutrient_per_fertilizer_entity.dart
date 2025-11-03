class ResultCountNutrientPerFertilizerEntity {
  final int? id;
  final String idRacikan;
  final String fertilizerName;
  final double fertilizerWeightGrams;
  final double totalPercentNitrogen;
  final double totalGramNitrogen;
  final double totalPercentPosfor;
  final double totalGramPosfor;
  final double totalPercentKalium;
  final double totalGramKalium;
  final double totalPercentBoron;
  final double totalGramBoron;
  final double totalPercentTembaga;
  final double totalGramTembaga;
  final double totalPercentBesi;
  final double totalGramBesi;
  final double totalPercentMagnesium;
  final double totalGramMagnesium;
  final double totalPercentMangan;
  final double totalGramMangan;
  final double totalPercentMolibdenum;
  final double totalGramMolibdenum;
  final double totalPercentSeng;
  final double totalGramSeng;
  final String? createdAt;

  const ResultCountNutrientPerFertilizerEntity({
    this.id,
    required this.idRacikan,
    required this.fertilizerName,
    required this.fertilizerWeightGrams,
    required this.totalPercentNitrogen,
    required this.totalGramNitrogen,
    required this.totalPercentPosfor,
    required this.totalGramPosfor,
    required this.totalPercentKalium,
    required this.totalGramKalium,
    required this.totalPercentBoron,
    required this.totalGramBoron,
    required this.totalPercentTembaga,
    required this.totalGramTembaga,
    required this.totalPercentBesi,
    required this.totalGramBesi,
    required this.totalPercentMagnesium,
    required this.totalGramMagnesium,
    required this.totalPercentMangan,
    required this.totalGramMangan,
    required this.totalPercentMolibdenum,
    required this.totalGramMolibdenum,
    required this.totalPercentSeng,
    required this.totalGramSeng,
    this.createdAt,
  });

  double operator [](String key) {
    switch (key) {
      case 'total_percent_nitrogen':
        return totalPercentNitrogen;
      case 'total_gram_nitrogen':
        return totalGramNitrogen;
      case 'total_percent_posfor':
        return totalPercentPosfor;
      case 'total_gram_posfor':
        return totalGramPosfor;
      case 'total_percent_kalium':
        return totalPercentKalium;
      case 'total_gram_kalium':
        return totalGramKalium;
      case 'total_percent_boron':
        return totalPercentBoron;
      case 'total_gram_boron':
        return totalGramBoron;
      case 'total_percent_tembaga':
        return totalPercentTembaga;
      case 'total_gram_tembaga':
        return totalGramTembaga;
      case 'total_percent_besi':
        return totalPercentBesi;
      case 'total_gram_besi':
        return totalGramBesi;
      case 'total_percent_magnesium':
        return totalPercentMagnesium;
      case 'total_gram_magnesium':
        return totalGramMagnesium;
      case 'total_percent_mangan':
        return totalPercentMangan;
      case 'total_gram_mangan':
        return totalGramMangan;
      case 'total_percent_molibdenum':
        return totalPercentMolibdenum;
      case 'total_gram_molibdenum':
        return totalGramMolibdenum;
      case 'total_percent_seng':
        return totalPercentSeng;
      case 'total_gram_seng':
        return totalGramSeng;
      default:
        throw ArgumentError('Nutrient $key tidak dikenal');
    }
  }
}
