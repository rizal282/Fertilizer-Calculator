import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfg_app/features/fertilizer/domain/entities/result_count_nutrients_all_fertilizers_entity.dart';
import 'package:pfg_app/features/fertilizer/domain/usecases/delete_fertilizer.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_event.dart';

class ItemResultCountFertilizers extends StatelessWidget {
  const ItemResultCountFertilizers({
    super.key,
    required this.rcnaf,
    required this.index,
  });

  final ResultCountNutrientsAllFertilizersEntity rcnaf;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hasil Perhitungan Pupuk Campuran #${index + 1}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tanggal: ${rcnaf.createdAt}",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () async {
                        // Tampilkan dialog konfirmasi
                        final bool? confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text(
                                  'Apakah Anda yakin ingin menghapus data ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false), // batal
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
                          await deleteFertilizer(context, rcnaf.idRacikan);

                          // Refresh data setelah dihapus
                          context.read<RcnafBloc>().add(LoadRcnafEvent());

                          // Tampilkan snackbar sukses
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Data berhasil dihapus!")),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ))
                ],
              ),
              Divider(height: 20, thickness: 0.8, color: Colors.white70),
              Text(
                "Total Berat Campuran Pupuk: ${rcnaf.fertilizerWeightGrams} g",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Nama Pupuk Campuran:",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                rcnaf.fertilizerNames,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kandungan Unsur Hara Total dalam Fertilizer Campuran:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nitrogen (N):"),
                  Text(
                      "${rcnaf.totalPercentNitrogen}% (${rcnaf.totalGramNitrogen} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Fosfor (P):"),
                  Text(
                      "${rcnaf.totalPercentPosfor}% (${rcnaf.totalGramPosfor} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Kalium (K):"),
                  Text(
                      "${rcnaf.totalPercentKalium}% (${rcnaf.totalGramKalium} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Boron (B):"),
                  Text(
                      "${rcnaf.totalPercentBoron}% (${rcnaf.totalGramBoron} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tembaga (Cu):"),
                  Text(
                      "${rcnaf.totalPercentTembaga}% (${rcnaf.totalGramTembaga} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Besi (Fe):"),
                  Text("${rcnaf.totalPercentBesi}% (${rcnaf.totalGramBesi} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Magnesium (Mg):"),
                  Text(
                      "${rcnaf.totalPercentMagnesium}% (${rcnaf.totalGramMagnesium} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Mangan (Mn):"),
                  Text(
                      "${rcnaf.totalPercentMangan}% (${rcnaf.totalGramMangan} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Molibdenum (Mo):"),
                  Text(
                      "${rcnaf.totalPercentMolibdenum}% (${rcnaf.totalGramMolibdenum} g)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Seng (Zn):"),
                  Text("${rcnaf.totalPercentSeng}% (${rcnaf.totalGramSeng} g)"),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Kalsium (Ca):"),
                  Text(
                      "${rcnaf.totalPercentKalsium}% (${rcnaf.totalGramKalsium} g)"),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sulfur (S):"),
                  Text(
                      "${rcnaf.totalPercentSulfur}% (${rcnaf.totalGramSulfur} g)"),
                ],
              ),
              // Tambahkan unsur hara lainnya sesuai kebutuhan
            ],
          ),
        ),
        Divider(height: 20, thickness: 0.8, color: Colors.grey[400]),
      ],
    );
  }
}
