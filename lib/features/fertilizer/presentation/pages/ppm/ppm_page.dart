import 'package:akurasipupuk/core/constants/ppm_options_const.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/ppm_form_count.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/volume_larutan_count_form.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/widget/ppm/zat_terlarut_mass_form_count.dart';
import 'package:flutter/material.dart';

class PpmPage extends StatefulWidget {
  const PpmPage({super.key});

  @override
  State<PpmPage> createState() => _PpmPageState();
}

class _PpmPageState extends State<PpmPage> {
  PpmType? selectedValuePpm;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Hitung Konsentrasi",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DropdownButtonFormField<PpmType>(
              //   decoration: InputDecoration(
              //     labelText: 'Pilih Perhitungan',
              //     border: OutlineInputBorder(),
              //   ),
              //   value: selectedValuePpm,
              //   items: PpmOptionsConst.ppmOptions.map((item) {
              //     return DropdownMenuItem<PpmType>(
              //       value: item,
              //       child: Text(item.itemName),
              //     );
              //   }).toList(),
              //   onChanged: (value) async {
              //     setState(() {
              //       selectedValuePpm = value;
              //     });
          
              //     // ➜ Jika itemId = 1, tampilkan popup
              //     if (value?.itemId == 1) {}
              //   },
              // ),
              // SizedBox(
              //   height: 12,
              // ),

               // if (selectedValuePpm != null && selectedValuePpm!.itemId == 1) ...[
              //   Text("Hitung PPM"),
              //   PpmFormCount(
              //     countType: selectedValuePpm!.itemId,
              //   ),
              // ],
              // if (selectedValuePpm != null && selectedValuePpm!.itemId == 2) ...[
              //   Text("Hitung Massa Zat Terlarut"),
              //   ZatTerlarutMassFormCount(
              //     countType: selectedValuePpm!.itemId,
              //   ),
              // ],
              // if (selectedValuePpm != null && selectedValuePpm!.itemId == 3) ...[
              //   Text("Hitung Volume Larutan"),
              //   VolumeLarutanCountForm(
              //     countType: selectedValuePpm!.itemId,
              //   ),
              // ],
          
              Text("Hitung PPM", style: TextStyle(fontWeight: FontWeight.bold),),
              PpmFormCount(
                countType: 1,
              ),
          
              SizedBox(
                height: 12,
              ),
          
              Text("Hitung Massa Zat Terlarut", style: TextStyle(fontWeight: FontWeight.bold),),
              ZatTerlarutMassFormCount(
                countType: 2,
              ),
          
              SizedBox(
                height: 12,
              ),
          
              Text("Hitung Volume Larutan", style: TextStyle(fontWeight: FontWeight.bold),),
              VolumeLarutanCountForm(
                countType: 3,
              ),
          
             
            ],
          ),
        ),
      ),
    ));
  }
}
