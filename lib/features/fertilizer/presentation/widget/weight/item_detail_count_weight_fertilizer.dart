import 'package:akurasipupuk/features/fertilizer/data/weight/response/weight_each_fertilizer_mix_response.dart';
import 'package:akurasipupuk/features/fertilizer/domain/weight/usecase/delete_count_weight_by_target_percent.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/total_ppm_count.dart';
import 'package:flutter/material.dart';

class ItemDetailCountWeightFertilizer extends StatelessWidget {
  final WeightEachFertilizerMixResponse weightEachFertilizerMixResponse;

  final adjustWeightFertilizerCtrl = TextEditingController();

  ItemDetailCountWeightFertilizer(
      {super.key, required this.weightEachFertilizerMixResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xFF3C8D40), borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                        ),
                        Text(weightEachFertilizerMixResponse
                                .nutrientTargetPercentInputted.createdAt ??
                            "-", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    Text(
                      "Hasil Hitung Otomatis",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () async {
                          final bool? confirmDelete = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi'),
                                content: const Text(
                                    'Apakah Anda yakin ingin menghapus data ini?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(false), // batal
                                    child: const Text('Batal'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(true), // konfirmasi hapus
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    child: const Text(
                                      'Hapus',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          // Jika pengguna menekan "Hapus"
                          if (confirmDelete == true) {
                            final idRacikan = weightEachFertilizerMixResponse
                                .nutrientTargetPercentInputted.idRacikan;

                            deleteCountWeightByTargetPercent(context, idRacikan)
                                .then((_) {
                              // Tampilkan snackbar sukses
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Data berhasil dihapus!")),
                              );
                            });
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Berat Pupuk yang Diambil",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                for (var fertilizer
                    in weightEachFertilizerMixResponse.fertilizersSelected) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(fertilizer.namaPupuk, style: TextStyle(color: Colors.white),),
                      Text("${fertilizer.weight}(g)", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ],
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "${weightEachFertilizerMixResponse.countTotalFertilizerMixGrams()}g",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total PPM", style: TextStyle(color: Colors.white),),
                        Text(
                            "${weightEachFertilizerMixResponse.ppmSolutionConcentrate.totalPpm?.toStringAsFixed(3)} mg/L", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Massa Zat Terlarut", style: TextStyle(color: Colors.white),),
                        Text(
                            "${weightEachFertilizerMixResponse.ppmSolutionConcentrate.totalMassOfSolute} g", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Volume Larutan", style:  TextStyle(color: Colors.white),),
                        Text(
                            "${weightEachFertilizerMixResponse.ppmSolutionConcentrate.totalSolutionVolume} L", style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TotalPpmCount(
                    weightFertilizerMix: weightEachFertilizerMixResponse
                        .countTotalFertilizerMixGrams(),
                    idRacikan: weightEachFertilizerMixResponse
                        .nutrientTargetPercentInputted.idRacikan,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 8,
          ),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(0xFF6BBF59),
              border: Border.all(color: Color(0xFF3C8D40)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
              "Target Kadar Unsur Hara Pupuk:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 4,),
                for (var entry in weightEachFertilizerMixResponse
                    .nutrientTargetPercentInputted
                    .toMap()
                    .entries) ...[
                  if (entry.key != "id" &&
                      entry.key != "id_user" &&
                      entry.key != "weight_target" &&
                      entry.key != "id_racikan" &&
                      entry.key != "created_at" &&
                      entry.key != "updated_at") ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key.replaceAll("_percent", ""), style: TextStyle(color: Colors.white)),
                        Text(
                          "${entry.value}%",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),

          // SizedBox(
          //   height: 8,
          // ),
          // Text(
          //   "Berat Pupuk yang Diambil:",
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          // ),

          // for (var tagetPercent in weightEachFertilizerMixResponse
          //     .resultCountWeightEachFertilizer) ...[
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(tagetPercent.fertilizerName),
          //       Text(
          //           "${tagetPercent.fertilizerWeight}g (${tagetPercent.fertilizerPercent}%) ",
          //           style: TextStyle(fontWeight: FontWeight.bold)),
          //     ],
          //   ),
          // ],

          // SizedBox(
          //   height: 8,
          // ),
          // Text(
          //   "Akurasi Unsur Hara Pupuk:",
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.grey),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   padding: const EdgeInsets.all(12),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text("Nitrogen (N):"),
          //           Text(
          //               "${weightEachFertilizerMixResponse.accuracyData.nitrogenPercent}%"),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text("Posfor (P):"),
          //           Text(
          //               "${weightEachFertilizerMixResponse.accuracyData.posforPercent}%"),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text("Kalium (K):"),
          //           Text(
          //               "${weightEachFertilizerMixResponse.accuracyData.kaliumPercent}%"),
          //         ],
          //       ),

          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text("Kalsium (Ca):"),
          //           Text(
          //               "${weightEachFertilizerMixResponse.accuracyData.kalsiumPercent}%"),
          //         ],
          //       ),

          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text("Sulfur (S):"),
          //           Text(
          //               "${weightEachFertilizerMixResponse.accuracyData.sulfurPercent}%"),
          //         ],
          //       ),

          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text("Magnesium (Mg):"),
          //           Text(
          //               "${weightEachFertilizerMixResponse.accuracyData.magnesiumPercent}%"),
          //         ],
          //       ),

          //       // Tambahkan unsur hara lainnya sesuai kebutuhan
          //     ],
          //   ),
          // ),

          SizedBox(
            height: 8,
          ),
          
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF8DCC70),
              border: Border.all(color: Color(0xFF3C8D40)),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
            "Jumlah Kandungan Unsur Hara Pupuk:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nitrogen (N):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.nitrogenPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Posfor (P):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.posforPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Kalium (K):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.kaliumPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sulfur (S):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.sulfurPercent}%"),
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Kalsium (Ca):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.kalsiumPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Boron (B):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.boronPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tembaga (Cu):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.tembagaPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Besi (Fe):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.besiPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Magnesium (Mg):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.magnesiumPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Mangan (Mn):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.manganPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Molibdenum (Mo):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.molibdenumPercent}%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Seng (Zn):"),
                    Text(
                        "${weightEachFertilizerMixResponse.resultCountWeightEachFertilizer.sengPercent}%"),
                  ],
                ),

               
                // Tambahkan unsur hara lainnya sesuai kebutuhan
              ],
            ),
          ),

          // SizedBox(
          //   height: 8,
          // ),
          // TextFormField(
          //   controller: adjustWeightFertilizerCtrl,
          //   keyboardType: TextInputType.numberWithOptions(),
          //   decoration: InputDecoration(
          //     border: const OutlineInputBorder(),
          //     labelText: 'Masukkan Berat Pupuk',
          //   ),
          // ),
          // SizedBox(
          //   height: 8,
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.blue,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           side: BorderSide(color: Colors.blue)),
          //     ),
          //     onPressed: () {
          //       final idRacikan = weightEachFertilizerMixResponse
          //           .nutrientTargetPercentInputted.idRacikan;

          //       final nutrientTargetPercent = weightEachFertilizerMixResponse.nutrientTargetPercentInputted;
          //       final fertilizersSelected = weightEachFertilizerMixResponse.fertilizersSelected;

          //       updateWeightFertilzer(
          //           context: context,
          //           idRacikan: idRacikan,
          //           newTargetWeightMix: adjustWeightFertilizerCtrl,
          //           nutrientTargetPercentModel: nutrientTargetPercent,
          //           fertilizersSelected: fertilizersSelected);
          //     },
          //     child: Text(
          //       "Sesuaikan Berat Pupuk",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
