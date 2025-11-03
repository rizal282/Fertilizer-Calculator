class FertilizerEntity {
  final int? id;
  final String idRacikan;
  final String namaPupuk;
  final double weight;
  final double nitrogen;
  final double posfor;
  final double kalium;
  final double boron;
  final double tembaga;
  final double besi;
  final double magnesium;
  final double mangan;
  final double molibdenum;
  final double seng;
  final String? createdAt;
  final String? updatedAt;

  const FertilizerEntity({
    this.id,
    required this.idRacikan,
    required this.namaPupuk,
    required this.weight,
    required this.nitrogen,
    required this.posfor,
    required this.kalium,
    required this.boron,
    required this.tembaga,
    required this.besi,
    required this.magnesium,
    required this.mangan,
    required this.molibdenum,
    required this.seng,
    this.createdAt,
    this.updatedAt,
  });
}