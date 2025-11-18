import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/entities/deviation_target_percent_entity.dart';

class DeviationTargetPercentModel extends DeviationTargetPercentEntity {
  const DeviationTargetPercentModel(
      {int? id,
      required String idRacikan,
      required double nitrogenPercent,
      required double posforPercent,
      required double kaliumPercent,
      required double boronPercent,
      required double tembagaPercent,
      required double besiPercent,
      required double magnesiumPercent,
      required double manganPercent,
      required double molibdenumPercent,
      required double sengPercent,
      required double kalsiumPercent,
      required double sulfurPercent,
      String? createdAt,
      String? updatedAt})
      : super(
            id: id,
            idRacikan: idRacikan,
            nitrogenPercent: nitrogenPercent,
            posforPercent: posforPercent,
            kaliumPercent: kaliumPercent,
            boronPercent: boronPercent,
            tembagaPercent: tembagaPercent,
            besiPercent: besiPercent,
            magnesiumPercent: magnesiumPercent,
            manganPercent: manganPercent,
            molibdenumPercent: molibdenumPercent,
            sengPercent: sengPercent,
            kalsiumPercent: kalsiumPercent,
            sulfurPercent: sulfurPercent,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory DeviationTargetPercentModel.fromEntity(
      DeviationTargetPercentEntity entity) {
    return DeviationTargetPercentModel(
      id: entity.id,
      idRacikan: entity.idRacikan,
      nitrogenPercent: entity.nitrogenPercent,
      posforPercent: entity.posforPercent,
      kaliumPercent: entity.kaliumPercent,
      boronPercent: entity.boronPercent,
      tembagaPercent: entity.tembagaPercent,
      besiPercent: entity.besiPercent,
      magnesiumPercent: entity.magnesiumPercent,
      manganPercent: entity.manganPercent,
      molibdenumPercent: entity.molibdenumPercent,
      sengPercent: entity.sengPercent,
      kalsiumPercent: entity.kalsiumPercent,
      sulfurPercent: entity.sulfurPercent,
      createdAt: entity.createdAt ??
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
      updatedAt: entity.updatedAt ??
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
    );
  }

  factory DeviationTargetPercentModel.fromMap(Map<String, dynamic> map) {
    return DeviationTargetPercentModel(
        id: map['id'],
        idRacikan: map['id_racikan'],
        nitrogenPercent: map['nitrogen_percent'],
        posforPercent: map['posfor_percent'],
        kaliumPercent: map['kalium_percent'],
        boronPercent: map['boron_percent'],
        tembagaPercent: map['tembaga_percent'],
        besiPercent: map['besi_percent'],
        magnesiumPercent: map['magnesium_percent'],
        manganPercent: map['mangan_percent'],
        molibdenumPercent: map['molibdenum_percent'],
        sengPercent: map['seng_percent'],
        kalsiumPercent: map['kalsium_percent'],
        sulfurPercent: map['sulfur_percent'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_racikan': idRacikan,
      'nitrogen_percent': nitrogenPercent,
      'posfor_percent': posforPercent,
      'kalium_percent': kaliumPercent,
      'boron_percent': boronPercent,
      'tembaga_percent': tembagaPercent,
      'besi_percent': besiPercent,
      'magnesium_percent': magnesiumPercent,
      'mangan_percent': manganPercent,
      'molibdenum_percent': molibdenumPercent,
      'seng_percent': sengPercent,
      'kalsium_percent': kalsiumPercent,
      'sulfur_percent': sulfurPercent,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
