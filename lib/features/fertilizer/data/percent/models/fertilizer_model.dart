import 'package:akurasipupuk/core/utils/date_format_util.dart';
import 'package:akurasipupuk/features/fertilizer/domain/percent/entities/fertilizer_entity.dart';

class FertilizerModel extends FertilizerEntity {
  const FertilizerModel({
    int? id,
    required String idRacikan,
    required String namaPupuk,
    required double weight,
    required double nitrogen,
    required double posfor,
    required double kalium,
    required double boron,
    required double tembaga,
    required double besi,
    required double magnesium,
    required double mangan,
    required double molibdenum,
    required double seng,
    required double kalsium,
    required double sulfur,
    String? createdAt,
    String? updatedAt,
  }) : super(
          id: id,
          idRacikan: idRacikan,
          namaPupuk: namaPupuk,
          weight: weight,
          nitrogen: nitrogen,
          posfor: posfor,
          kalium: kalium,
          boron: boron,
          tembaga: tembaga,
          besi: besi,
          magnesium: magnesium,
          mangan: mangan,
          molibdenum: molibdenum,
          seng: seng,
          kalsium: kalsium,
          sulfur: sulfur,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// ✅ Konversi dari Entity (domain) ke Model (data)
  factory FertilizerModel.fromEntity(FertilizerEntity entity) {
    return FertilizerModel(
      id: entity.id,
      idRacikan: entity.idRacikan,
      namaPupuk: entity.namaPupuk,
      weight: entity.weight,
      nitrogen: entity.nitrogen,
      posfor: entity.posfor,
      kalium: entity.kalium,
      boron: entity.boron,
      tembaga: entity.tembaga,
      besi: entity.besi,
      magnesium: entity.magnesium,
      mangan: entity.mangan,
      molibdenum: entity.molibdenum,
      seng: entity.seng,
      kalsium: entity.kalsium,
      sulfur: entity.sulfur,
      createdAt: entity.createdAt ??
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
      updatedAt: entity.updatedAt ??
          DateFormatUtil.formatDateToYYYYMMDD(DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_racikan': idRacikan,
      'nama_pupuk': namaPupuk,
      'weight': weight,
      'nitrogen': nitrogen,
      'posfor': posfor,
      'kalium': kalium,
      'boron': boron,
      'tembaga': tembaga,
      'besi': besi,
      'magnesium': magnesium,
      'mangan': mangan,
      'molibdenum': molibdenum,
      'seng': seng,
      'kalsium': kalsium,
      'sulfur': sulfur,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory FertilizerModel.fromMap(Map<String, dynamic> map) {
    return FertilizerModel(
      id: map['id'],
      idRacikan: map['id_racikan'],
      namaPupuk: map['nama_pupuk'],
      weight: map['weight'] ?? 0.0,
      nitrogen: map['nitrogen'] ?? 0.0,
      posfor: map['posfor'] ?? 0.0,
      kalium: map['kalium'] ?? 0.0,
      boron: map['boron'] ?? 0.0,
      tembaga: map['tembaga'] ?? 0.0,
      besi: map['besi'] ?? 0.0,
      magnesium: map['magnesium'] ?? 0.0,
      mangan: map['mangan'] ?? 0.0,
      molibdenum: map['molibdenum'] ?? 0.0,
      seng: map['seng'] ?? 0.0,
      kalsium: map['kalsium'] ?? 0.0,
      sulfur: map['sulfur'] ?? 0.0,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
