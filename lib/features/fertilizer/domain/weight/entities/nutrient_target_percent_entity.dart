class NutrientTargetPercentEntity {
  final int? id;
  final String idUser;
  final String idRacikan;
  final double weightTarget;
  final double nitrogenPercent;
  final double posforPercent;
  final double kaliumPercent;
  // final double boronPercent;
  // final double tembagaPercent;
  // final double besiPercent;
  final double magnesiumPercent;
  // final double manganPercent;
  // final double molibdenumPercent;
  // final double sengPercent;
  final double kalsiumPercent;
  final double sulfurPercent;
  final String? createdAt;
  final String? updatedAt;

  const NutrientTargetPercentEntity({
    this.id,
    required this.idUser,
    required this.idRacikan,
    required this.weightTarget,
    required this.nitrogenPercent,
    required this.posforPercent,
    required this.kaliumPercent,
    // required this.boronPercent,
    // required this.tembagaPercent,
    // required this.besiPercent,
    required this.magnesiumPercent,
    // required this.manganPercent,
    // required this.molibdenumPercent,
    // required this.sengPercent,
    required this.kalsiumPercent,
    required this.sulfurPercent,
    this.createdAt,
    this.updatedAt
  });
}
