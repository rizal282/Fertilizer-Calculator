
import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/domain/ppm/entities/ppm_solution_concentration_entity.dart';

class PpmSolutionConcentrateModel extends PpmSolutionConcentrationEntity {
  PpmSolutionConcentrateModel(
      {int? id,
      String? idRacikan,
      double? totalPpm,
      double? totalMassOfSolute,
      double? totalSolutionVolume,
      String? sourcePpm,
      String? countType,
      String? createdAt,
      String? updatedAt})
      : super(
            id: id,
            idRacikan: idRacikan,
            totalPpm: totalPpm,
            totalMassOfSolute: totalMassOfSolute,
            totalSolutionVolume: totalSolutionVolume,
            sourcePpm: sourcePpm,
            countType: countType,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory PpmSolutionConcentrateModel.fromEntity(
      PpmSolutionConcentrationEntity entity) {
    return PpmSolutionConcentrateModel(
        id: entity.id,
        idRacikan: entity.idRacikan,
        totalPpm: entity.totalPpm,
        totalMassOfSolute: entity.totalMassOfSolute,
        totalSolutionVolume: entity.totalSolutionVolume,
        sourcePpm: entity.sourcePpm,
        countType:  entity.countType,
        createdAt: entity.createdAt ??
            DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
        updatedAt: entity.updatedAt);
  }

  factory PpmSolutionConcentrateModel.fromMap(Map<String, dynamic> map) {
    return PpmSolutionConcentrateModel(
        id: map['id'] ?? 0,
        idRacikan: map['id_racikan'] ?? '-',
        totalMassOfSolute: map['total_mass_of_solute'] ?? 0.0,
        totalPpm: map['total_ppm'] ?? 0.0,
        totalSolutionVolume: map['total_solution_volume'] ?? 0.0,
        sourcePpm: map['source_ppm'],
        countType: map['count_type'],
        createdAt: map['created_at'] ?? '-',
        updatedAt: map['updated_at'] ?? '-');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_racikan': idRacikan,
      'total_mass_of_solute': totalMassOfSolute,
      'total_ppm': totalPpm,
      'total_solution_volume': totalSolutionVolume,
      'source_ppm': sourcePpm,
      'count_type': countType,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }
}
