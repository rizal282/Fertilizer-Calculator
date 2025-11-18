import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/features/auth/domain/usecase/google_sign_out_usecase.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/percent/fertilization_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/percent/fertilizer_calculate_result_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/ppm/ppm_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/ppm/ppm_result_count_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/weight/fertilizer_weight_page.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/pages/weight/fertilizer_weight_result_detail_page.dart';
import 'package:akurasipupuk/features/home/presentation/widget/button_constraint_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: SvgPicture.asset(
                  StringConst.imageAppHome,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonConstraintBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FertilizationPage()));
                        },
                        child: Text(
                          "Manual",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(width: 10),
                  ButtonConstraintBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.blue)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FertilizerCalculateResultPage()));
                        },
                        child: Text(
                          "Hasil Manual",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonConstraintBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FertilizerWeightPage()));
                        },
                        child: Text(
                          "Otomatis",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(width: 10),
                  ButtonConstraintBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.blue)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FertilizerWeightResultDetailPage()));
                        },
                        child: Text(
                          "Hasil Otomatis",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),

               SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonConstraintBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PpmPage()));
                        },
                        child: Text(
                          "PPM",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(width: 10),
                  ButtonConstraintBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.blue)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PpmResultCountPage()));
                        },
                        child: Text(
                          "Hasil Konsentrasi",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),


              SizedBox(
                height: 12,
              ),
              ElevatedButton.icon(
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await signOutFromGoogle(context);
                  },
                  label: Text("Keluar"))
            ],
          ),
        ),
      ),
    );
  }
}
