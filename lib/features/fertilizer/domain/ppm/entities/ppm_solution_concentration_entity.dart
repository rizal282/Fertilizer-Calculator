class PpmSolutionConcentrationEntity {
  final int? id;
  final String? idRacikan;
  final double? totalPpm;
  final double? totalMassOfSolute;
  final double? totalSolutionVolume;
  final String? sourcePpm;
  final String? countType;
  final String? createdAt;
  final String? updatedAt;

  PpmSolutionConcentrationEntity({
    this.id,
    this.idRacikan,
    this.totalPpm,
    this.totalMassOfSolute,
    this.totalSolutionVolume,
    this.sourcePpm,
    this.countType,
    this.createdAt,
    this.updatedAt}
  );
}