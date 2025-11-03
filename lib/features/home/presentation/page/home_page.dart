import 'package:flutter/material.dart';
import 'package:pfg_app/features/fertilizer/presentation/pages/fertilization_page.dart';
import 'package:pfg_app/features/fertilizer/presentation/pages/fertilizer_calculate_result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FertilizationPage()));
                  },
                  child: Text("Hitung Pupuk", style: TextStyle(color: Colors.white),)),
              SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FertilizerCalculateResultPage()));
                  },
                  child: Text("Lihat Hasil Hitung", style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
