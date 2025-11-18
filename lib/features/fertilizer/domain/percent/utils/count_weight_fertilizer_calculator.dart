import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';

class CountWeightFertilizerCalculator {
  static Map<String, dynamic> countWeightFertilizer(
    FertilizerTargetInput target,
    List<FertilizerWeightInput> fertilizers,
  ) {
    double totalWeightGram = 0;

    // Total unsur mikro & makro dalam GRAM bukan persentase
    Map<String, double> totalNutrients = {
      'Nitrogen': 0,
      'Posfor': 0,
      'Kalium': 0,
      'Kalsium': 0,
      'Sulfur': 0,
      'Magnesium': 0,
      'Boron': 0,
      'Tembaga': 0,
      'Fesi': 0,
      'Mangan': 0,
      'Molibdenum': 0,
      'Seng': 0,
    };

    // ---------------------------
    // 1. Menghitung total gram nutrisi
    // ---------------------------
    for (var f in fertilizers) {
      final double weightGram =
          double.tryParse(f.weightGramInput.text.trim()) ?? 0;

      totalWeightGram += weightGram;

      f.nutrients.forEach((name, controller) {
        double percent = double.tryParse(controller.text.trim()) ?? 0;

        // gram nutrisi = (persentase / 100) * berat gram
        double nutrientGram = (percent / 100) * weightGram;

        totalNutrients[name] = (totalNutrients[name] ?? 0) + nutrientGram;
      });
    }

    // -----------------------------------
    // 2. Mengubah total gram → persen campuran
    // -----------------------------------
    Map<String, double> percentResult = {};
    totalNutrients.forEach((name, gramValue) {
      double resultNutrient = totalWeightGram == 0 ? 0 : (gramValue / totalWeightGram) * 100;

      percentResult[name] =
          double.parse(resultNutrient.toStringAsFixed(3));
    });

    // -----------------------------------
    // 3. Hitung Deviasi & Akurasi
    // -----------------------------------
    Map<String, double> deviation = {};
    Map<String, double> accuracy = {};

    target.nutrientsTargetPercent.forEach((name, controller) {
      double targetPercent = double.tryParse(controller.text.trim()) ?? 0;
      double resultPercent = percentResult[name] ?? 0;

      double dev = (resultPercent - targetPercent).abs();
      deviation[name] =  double.parse(dev.toStringAsFixed(3));

      double acc = targetPercent == 0
          ? 100
          : (100 - (dev / targetPercent * 100)).clamp(0, 100);
      accuracy[name] = double.parse(acc.toStringAsFixed(3));
    });

    double avgAccuracy = accuracy.isEmpty
        ? 0
        : accuracy.values.reduce((a, b) => a + b) / accuracy.length;

    // -----------------------------------
    // 4. Rekomendasi (berdasarkan deviasi terbesar)
    // -----------------------------------
    String maxDevKey = deviation.entries.isEmpty
        ? ""
        : deviation.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    String recommendedFertilizer = "";
    double recommendedAdjustmentGram = 0;

    if (maxDevKey.isNotEmpty) {
      FertilizerWeightInput? richest;

      for (var f in fertilizers) {
        double val =
            double.tryParse(f.nutrients[maxDevKey]?.text.trim() ?? "0") ?? 0;

        if (richest == null) {
          richest = f;
        } else {
          final currentRichestValue = double.tryParse(
                  richest.nutrients[maxDevKey]?.text.trim() ?? "0") ??
              0;

          if (val > currentRichestValue) {
            richest = f;
          }
        }
      }

      if (richest != null) {
        recommendedFertilizer =
            richest.fertilizerNameSelected ?? "Pupuk Tidak Diketahui";

        // rekomendasi penambahan gram  (10% dari gram deviasi)
        recommendedAdjustmentGram =
            deviation[maxDevKey]! * totalWeightGram * 0.1;
      }
    }

    // -----------------------------------
    // 5. Output untuk UI
    // -----------------------------------
    return {
      "totalWeightGram": totalWeightGram,
      "percentResult": percentResult,
      "deviation": deviation,
      "accuracy": accuracy,
      "avgAccuracy": avgAccuracy,
      "recommendation": {
        "nutrient": maxDevKey,
        "fertilizer": recommendedFertilizer,
        "adjustGram": recommendedAdjustmentGram,
      }
    };
  }

  // static Map<String, dynamic> countWeightFertilizer(
  //   FertilizerTargetInput targetPercentInput,
  //   List<FertilizerWeightInput> fertilizers, {
  //   double? baseScale,
  //   bool generateMultipleSolutions = true
  // }) {

  //   try {
  //     // Validasi input
  //     if (fertilizers.isEmpty) {
  //       return {
  //         'success': false,
  //         'error': 'Tidak ada pupuk yang diinput',
  //       };
  //     }

  //     // Ambil target nutrisi yang tidak kosong
  //     Map<String, double> targets = {};
  //     targetPercentInput.nutrientsTargetPercent.forEach((nutrient, controller) {
  //       if (controller.text.isNotEmpty) {
  //         double? value = double.tryParse(controller.text);
  //         if (value != null && value > 0) {
  //           targets[nutrient] = value;
  //         }
  //       }
  //     });

  //     if (targets.isEmpty) {
  //       return {
  //         'success': false,
  //         'error': 'Target nutrisi harus diisi minimal 1 unsur',
  //       };
  //     }

  //     // Ambil data nutrisi dari setiap pupuk
  //     List<Map<String, double>> fertilizerNutrients = [];
  //     List<String> fertilizerNames = [];

  //     for (var fert in fertilizers) {
  //       String name = fert.fertilizerNameSelected ??
  //                    fert.manufacturerName.text;
  //       if (name.isEmpty) name = 'Pupuk ${fertilizers.indexOf(fert) + 1}';

  //       fertilizerNames.add(name);

  //       Map<String, double> nutrients = {};
  //       fert.nutrients.forEach((nutrient, controller) {
  //         double value = double.tryParse(controller.text) ?? 0.0;
  //         nutrients[nutrient] = value;
  //       });
  //       fertilizerNutrients.add(nutrients);
  //     }

  //     // Hitung berat absolut masing-masing pupuk
  //     List<Map<String, dynamic>> allSolutions = [];

  //     if (generateMultipleSolutions) {
  //       // Generate 3 solusi dengan strategi berbeda
  //       allSolutions = _generateMultipleSolutions(
  //         fertilizers: fertilizerNutrients,
  //         fertilizerNames: fertilizerNames,
  //         targets: targets,
  //       );
  //     } else {
  //       // Single solution (default)
  //       Map<String, double> singleSolution = _calculateAbsoluteWeights(
  //         fertilizers: fertilizerNutrients,
  //         fertilizerNames: fertilizerNames,
  //         targets: targets,
  //         strategy: 'balanced',
  //       );
  //       allSolutions.add({
  //         'weights': singleSolution,
  //         'name': 'Solusi Optimal',
  //         'description': 'Solusi seimbang dengan distribusi merata',
  //       });
  //     }

  //     // Process semua solusi
  //     List<Map<String, dynamic>> processedSolutions = [];

  //     for (var solution in allSolutions) {
  //       Map<String, double> absoluteWeights = solution['weights'];

  //       // Scale jika baseScale diberikan
  //       double scaleFactor = baseScale ?? 1.0;
  //       Map<String, double> weights = {};
  //       absoluteWeights.forEach((name, weight) {
  //         weights[name] = weight * scaleFactor;
  //       });

  //       double totalWeight = weights.values.fold(0.0, (sum, w) => sum + w);

  //       // Verifikasi hasil
  //       Map<String, dynamic> verificationResult = _verifyComposition(
  //         weights: weights,
  //         fertilizers: fertilizerNutrients,
  //         fertilizerNames: fertilizerNames,
  //         totalWeight: totalWeight,
  //       );

  //       Map<String, double> actualComposition = verificationResult['composition'];
  //       Map<String, double> actualWeight = verificationResult['weight'];

  //       // Hitung error
  //       Map<String, double> errors = {};
  //       double avgError = 0.0;
  //       targets.forEach((nutrient, targetValue) {
  //         double actual = actualComposition[nutrient] ?? 0.0;
  //         double error = ((actual - targetValue).abs() / targetValue * 100);
  //         errors[nutrient] = error;
  //         avgError += error;
  //       });
  //       avgError /= targets.length;

  //       // Hitung rasio
  //       Map<String, double> ratios = {};
  //       absoluteWeights.forEach((name, weight) {
  //         ratios[name] = weight / absoluteWeights.values.fold(0.0, (sum, w) => sum + w);
  //       });

  //       processedSolutions.add({
  //         'name': solution['name'],
  //         'description': solution['description'],
  //         'weights': weights,
  //         'absoluteWeights': absoluteWeights,
  //         'ratios': ratios,
  //         'actualComposition': actualComposition,
  //         'actualWeight': actualWeight,
  //         'errors': errors,
  //         'avgError': avgError,
  //         'totalWeight': totalWeight,
  //       });
  //     }

  //     // Sort by average error (best first)
  //     processedSolutions.sort((a, b) =>
  //       (a['avgError'] as double).compareTo(b['avgError'] as double));

  //     return {
  //       'success': true,
  //       'solutions': processedSolutions,
  //       'targetComposition': targets,
  //       'scaleFactor': baseScale ?? 1.0,
  //       'multipleSolutions': generateMultipleSolutions,
  //     };
  //   } catch (e) {
  //     return {
  //       'success': false,
  //       'error': 'Terjadi kesalahan: $e',
  //     };
  //   }
  // }

  //  static Map<String, dynamic> _verifyComposition({
  //   required Map<String, double> weights,
  //   required List<Map<String, double>> fertilizers,
  //   required List<String> fertilizerNames,
  //   required double totalWeight,
  // }) {
  //   Map<String, double> composition = {};
  //   Map<String, double> weightPerNutrient = {};
  //   double actualTotal = 0.0;

  //   for (int i = 0; i < fertilizers.length; i++) {
  //     String name = fertilizerNames[i];
  //     double weight = weights[name] ?? 0.0;
  //     actualTotal += weight;

  //     fertilizers[i].forEach((nutrient, value) {
  //       double nutrientWeight = weight * value / 100;
  //       composition[nutrient] =
  //         (composition[nutrient] ?? 0.0) + (weight * value);
  //       weightPerNutrient[nutrient] =
  //         (weightPerNutrient[nutrient] ?? 0.0) + nutrientWeight;
  //     });
  //   }

  //   // Konversi ke persentase
  //   if (actualTotal > 0) {
  //     composition.forEach((nutrient, value) {
  //       composition[nutrient] = double.parse((value / actualTotal).toStringAsFixed(4));
  //     });
  //   }

  //   // Bulatkan weight ke 4 desimal
  //   weightPerNutrient.forEach((nutrient, value) {
  //     weightPerNutrient[nutrient] = double.parse(value.toStringAsFixed(4));
  //   });

  //   return {
  //     'composition': composition,
  //     'weight': weightPerNutrient,
  //   };
  // }

  // static Map<String, double> _calculateAbsoluteWeights({
  //   required List<Map<String, double>> fertilizers,
  //   required List<String> fertilizerNames,
  //   required Map<String, double> targets,
  //   String strategy = 'balanced',
  // }) {
  //   int n = fertilizers.length;
  //   Map<String, double> weights = {};

  //   // Inisialisasi berbeda berdasarkan strategi
  //   if (strategy == 'minimize_total') {
  //     // Mulai dengan nilai sangat kecil
  //     for (int i = 0; i < n; i++) {
  //       weights[fertilizerNames[i]] = 1.0;
  //     }
  //   } else if (strategy == 'balanced') {
  //     // Mulai dengan nilai seimbang
  //     for (int i = 0; i < n; i++) {
  //       weights[fertilizerNames[i]] = 10.0;
  //     }
  //   } else if (strategy == 'favor_primary') {
  //     // Inisialisasi berdasarkan kandungan nutrisi target
  //     for (int i = 0; i < n; i++) {
  //       double score = 0.0;
  //       targets.forEach((nutrient, targetVal) {
  //         score += (fertilizers[i][nutrient] ?? 0.0) * targetVal;
  //       });
  //       weights[fertilizerNames[i]] = max(1.0, score / 10.0);
  //     }
  //   }

  //   // Parameter optimasi disesuaikan dengan strategi
  //   double learningRate = strategy == 'minimize_total' ? 0.03 : 0.05;
  //   int maxIterations = 100000;
  //   double minError = 0.0001;
  //   double previousError = double.infinity;
  //   int stagnantCount = 0;

  //   Map<String, double> velocity = {};
  //   Map<String, double> momentum = {};
  //   for (var name in fertilizerNames) {
  //     velocity[name] = 0.0;
  //     momentum[name] = 0.0;
  //   }
  //   double momentumFactor = 0.9;
  //   double decayRate = 0.999;

  //   // Penalty untuk strategi minimize_total
  //   double totalWeightPenalty = strategy == 'minimize_total' ? 0.1 : 0.0;

  //   for (int iter = 0; iter < maxIterations; iter++) {
  //     double totalWeight = weights.values.fold(0.0, (sum, w) => sum + w);
  //     Map<String, double> totalNutrients = {};

  //     for (int i = 0; i < n; i++) {
  //       String name = fertilizerNames[i];
  //       double w = weights[name]!;

  //       fertilizers[i].forEach((nutrient, percent) {
  //         double amount = w * percent / 100.0;
  //         totalNutrients[nutrient] = (totalNutrients[nutrient] ?? 0.0) + amount;
  //       });
  //     }

  //     Map<String, double> actualPercent = {};
  //     if (totalWeight > 0) {
  //       totalNutrients.forEach((nutrient, amount) {
  //         actualPercent[nutrient] = (amount / totalWeight) * 100.0;
  //       });
  //     }

  //     double totalError = 0.0;
  //     Map<String, double> nutrientErrors = {};

  //     targets.forEach((nutrient, targetPercent) {
  //       double actual = actualPercent[nutrient] ?? 0.0;
  //       double error = targetPercent - actual;
  //       nutrientErrors[nutrient] = error;
  //       totalError += error * error;
  //     });

  //     // Tambahkan penalty untuk total weight jika minimize
  //     if (strategy == 'minimize_total') {
  //       totalError += totalWeightPenalty * totalWeight;
  //     }

  //     // Penalty untuk distribusi tidak seimbang jika balanced
  //     if (strategy == 'balanced') {
  //       double avgWeight = totalWeight / n;
  //       double variance = 0.0;
  //       weights.forEach((name, w) {
  //         variance += pow(w - avgWeight, 2);
  //       });
  //       totalError += 0.01 * variance / n;
  //     }

  //     totalError = sqrt(totalError / targets.length);

  //     if (totalError < minError) {
  //       break;
  //     }

  //     if ((previousError - totalError).abs() < 0.00001) {
  //       stagnantCount++;
  //       if (stagnantCount > 100) {
  //         learningRate *= 1.1;
  //         stagnantCount = 0;
  //       }
  //     } else {
  //       stagnantCount = 0;
  //     }
  //     previousError = totalError;

  //     for (int i = 0; i < n; i++) {
  //       String name = fertilizerNames[i];
  //       double gradient = 0.0;

  //       targets.forEach((nutrient, targetPercent) {
  //         double fertNutrientPercent = fertilizers[i][nutrient] ?? 0.0;
  //         double actualNutrientPercent = actualPercent[nutrient] ?? 0.0;
  //         double error = nutrientErrors[nutrient] ?? 0.0;

  //         double derivative = (fertNutrientPercent - actualNutrientPercent) / totalWeight;
  //         gradient += 2.0 * error * derivative * 100.0;
  //       });

  //       // Tambahkan gradient untuk minimize total weight
  //       if (strategy == 'minimize_total') {
  //         gradient -= totalWeightPenalty;
  //       }

  //       // Tambahkan gradient untuk balance
  //       if (strategy == 'balanced') {
  //         double avgWeight = totalWeight / n;
  //         gradient -= 0.02 * (weights[name]! - avgWeight) / n;
  //       }

  //       momentum[name] = momentumFactor * momentum[name]! + (1 - momentumFactor) * gradient;
  //       velocity[name] = decayRate * velocity[name]! + learningRate * momentum[name]!;

  //       double newWeight = weights[name]! + velocity[name]!;
  //       weights[name] = max(0.5, min(100.0, newWeight));
  //     }

  //     if (iter % 1000 == 0 && iter > 0) {
  //       learningRate *= 0.99;
  //     }

  //     if (learningRate < 0.0001) {
  //       learningRate = 0.01;
  //     }
  //   }

  //   weights.forEach((name, weight) {
  //     weights[name] = double.parse(weight.toStringAsFixed(2));
  //   });

  //   return weights;
  // }

  // static List<Map<String, dynamic>> _generateMultipleSolutions({
  //   required List<Map<String, double>> fertilizers,
  //   required List<String> fertilizerNames,
  //   required Map<String, double> targets,
  // }) {
  //   List<Map<String, dynamic>> solutions = [];

  //   // Solusi 1: Minimize Total Weight (paling hemat)
  //   solutions.add({
  //     'weights': _calculateAbsoluteWeights(
  //       fertilizers: fertilizers,
  //       fertilizerNames: fertilizerNames,
  //       targets: targets,
  //       strategy: 'minimize_total',
  //     ),
  //     'name': 'Solusi Hemat',
  //     'description': 'Total berat minimal - paling hemat pupuk',
  //   });

  //   // Solusi 2: Balanced Distribution (distribusi merata)
  //   solutions.add({
  //     'weights': _calculateAbsoluteWeights(
  //       fertilizers: fertilizers,
  //       fertilizerNames: fertilizerNames,
  //       targets: targets,
  //       strategy: 'balanced',
  //     ),
  //     'name': 'Solusi Seimbang',
  //     'description': 'Distribusi merata antar pupuk - tidak ada yang terlalu dominan',
  //   });

  //   // Solusi 3: Favor Primary Nutrients (utamakan pupuk dengan nutrisi tinggi)
  //   solutions.add({
  //     'weights': _calculateAbsoluteWeights(
  //       fertilizers: fertilizers,
  //       fertilizerNames: fertilizerNames,
  //       targets: targets,
  //       strategy: 'favor_primary',
  //     ),
  //     'name': 'Solusi Efisien',
  //     'description': 'Maksimalkan pupuk dengan kandungan nutrisi tertinggi',
  //   });

  //   return solutions;
  // }

  // static Map<String, dynamic> countWeightFertilizer(
  //   FertilizerTargetInput targetPercentInput,
  //   List<FertilizerWeightInput> fertilizers, {
  //   double totalWeightGram = 100.0,
  // }) {
  //   // --- 1️⃣ Kumpulkan semua unsur ---
  //   final Set<String> nutrientKeyNames = {};
  //   for (final fert in fertilizers) {
  //     nutrientKeyNames.addAll(fert.nutrients.keys);
  //   }
  //   nutrientKeyNames.addAll(targetPercentInput.nutrientsTargetPercent.keys);
  //   final nutrientList = nutrientKeyNames.toList();

  //   final n = fertilizers.length;
  //   final m = nutrientList.length;

  //   // --- 2️⃣ Matriks A (fraksi kandungan pupuk) ---
  //   final A = Matrix.fromList(List.generate(
  //     m,
  //     (i) => List.generate(
  //       n,
  //       (j) {
  //         final txt = fertilizers[j].nutrients[nutrientList[i]]!.text;
  //         final val = txt.isEmpty
  //             ? 0.0
  //             : double.parse(decimalTextContainsCommaFormatter(txt));
  //         return val / 100.0;
  //       },
  //     ),
  //   ));

  //   // --- 3️⃣ Vektor target unsur (fraksi) ---
  //   final b = Vector.fromList(List.generate(m, (i) {
  //     final key = nutrientList[i];
  //     if (!targetPercentInput.nutrientsTargetPercent.containsKey(key))
  //       return 0.0;
  //     final ctrl = targetPercentInput.nutrientsTargetPercent[key]!;
  //     final txt = ctrl.text;
  //     final val = txt.isEmpty
  //         ? 0.0
  //         : double.parse(decimalTextContainsCommaFormatter(txt));
  //     return val / 100.0;
  //   }));

  //   // --- 4️⃣ NNLS (Lawson-Hanson) robust implementation ---
  //   Vector nnls(Matrix A, Vector b, {int maxIter = 500, double eps = 1e-12}) {
  //     final int m = A.rowsNum;
  //     final int n = A.columnsNum;

  //     Vector x = Vector.filled(n, 0.0);
  //     final Set<int> passiveSet = <int>{};

  //     for (int iter = 0; iter < maxIter; iter++) {
  //       // residual and gradient
  //       final r = b - A * x;
  //       final w = A.transpose() * r;

  //       // find index with largest positive w not in passive
  //       int t = -1;
  //       double maxW = 0.0;

  //       for (int i = 0; i < n; i++) {
  //         final wDouble = w[i] as double;
  //         if (!passiveSet.contains(i) && wDouble > maxW + eps) {
  //           maxW = wDouble;
  //           t = i;
  //         }
  //       }
  //       if (t == -1) break; // optimal (no positive gradient)

  //       passiveSet.add(t);

  //       // build activeA as matrix with columns = A[:, P]
  //       List<int> P = passiveSet.toList();
  //       // if P is empty (shouldn't happen because we just added t) protect:
  //       if (P.isEmpty) break;

  //       Matrix activeA = _buildSubMatrixByColumns(A, P);

  //       // solve least squares for active set: min ||activeA * z - b||^2
  //       // (activeA^T * activeA) z = activeA^T * b
  //       Matrix activeAtA = activeA.transpose() * activeA;

  //       // regularize if needed
  //       Matrix activeAtA_reg;
  //       try {
  //         activeAtA_reg = activeAtA;
  //         // check determinant-ish by trying inverse
  //         activeAtA_reg.inverse();
  //       } catch (_) {
  //         // add tiny diagonal regularization
  //         activeAtA_reg = activeAtA + Matrix.identity(activeAtA.rowsNum) * 1e-8;
  //       }

  //       Vector activeAtb = (activeA.transpose() * b) as Vector;
  //       Vector z;
  //       try {
  //         z = (activeAtA_reg.inverse() * activeAtb) as Vector;
  //       } catch (_) {
  //         // fallback: use pseudo solution via small-regularized inverse
  //         z = ((activeAtA_reg + Matrix.identity(activeAtA_reg.rowsNum) * 1e-8)
  //                 .inverse() *
  //             activeAtb) as Vector;
  //       }

  //       // expand z to full size
  //       Vector zFull = Vector.filled(n, 0.0);
  //       for (int k = 0; k < P.length; k++) {
  //         zFull = zFull.set(P[k], z[k]);
  //       }

  //       // enforce non-negativity by inner loop
  //       while (zFull.any((v) => v < 0.0)) {
  //         double alpha = double.infinity;
  //         for (final i in P) {
  //           if (zFull[i] < 0.0) {
  //             final denom = (x[i] - zFull[i]);
  //             if (denom.abs() > eps) {
  //               alpha = min(alpha, x[i] / denom);
  //             }
  //           }
  //         }
  //         if (alpha.isInfinite || alpha <= 0.0) {
  //           // numerical issue — break to avoid infinite loop
  //           break;
  //         }
  //         // x = x + alpha * (zFull - x)
  //         x = x + (zFull - x) * alpha;

  //         // remove near-zero entries from passiveSet
  //         passiveSet.removeWhere((i) => x[i].abs() <= 1e-12);

  //         // rebuild P and activeA
  //         P = passiveSet.toList();
  //         if (P.isEmpty) {
  //           zFull = Vector.filled(n, 0.0);
  //           break;
  //         }
  //         activeA = _buildSubMatrixByColumns(A, P);

  //         activeAtA = activeA.transpose() * activeA;
  //         try {
  //           activeAtA_reg = activeAtA;
  //           activeAtA_reg.inverse();
  //         } catch (_) {
  //           activeAtA_reg =
  //               activeAtA + Matrix.identity(activeAtA.rowsNum) * 1e-8;
  //         }
  //         activeAtb = (activeA.transpose() * b) as Vector;
  //         try {
  //           z = (activeAtA_reg.inverse() * activeAtb) as Vector;
  //         } catch (_) {
  //           z = ((activeAtA_reg + Matrix.identity(activeAtA_reg.rowsNum) * 1e-8)
  //                   .inverse() *
  //               activeAtb) as Vector;
  //         }

  //         zFull = Vector.filled(n, 0.0);
  //         for (int k = 0; k < P.length; k++) {
  //           zFull = zFull.set(P[k], z[k]);
  //         }
  //       } // end while negative

  //       // accept zFull
  //       x = zFull;
  //     } // end iter

  //     // final safeguard: clamp tiny negatives to zero
  //     final List<double> xList =
  //         x.toList().map((v) => v < 0 ? 0.0 : v).toList();
  //     return Vector.fromList(xList);
  //   } // end nnls

  //   // --- compute raw result via NNLS (with try fallback) ---
  //   Vector rawResult;
  //   try {
  //     rawResult = nnls(A, b, maxIter: 1000);
  //   } catch (e) {
  //     // fallback to pseudo-inverse least squares
  //     final AT = A.transpose();
  //     final ATA = AT * A;
  //     final ATb = AT * b;
  //     final ATA_reg = ATA + Matrix.identity(ATA.rowsNum) * 1e-8;
  //     final Matrix sol = ATA_reg.inverse() * ATb;
  //     // sol might be matrix or vector; ensure vector
  //     if (sol.columnsNum == 1) {
  //       rawResult = sol.getColumn(0);
  //     } else {
  //       rawResult = Vector.fromList(sol.toList().expand((r) => r).toList());
  //     }
  //   }

  //   // --- 5️⃣ Normalize to sum = 1 ---
  //   List<double> xList = rawResult.toList().map((v) => max(0.0, v)).toList();
  //   final total = xList.fold(0.0, (a, b) => a + b);
  //   final normalized = (total <= 0)
  //       ? List.filled(xList.length, 0.0)
  //       : xList.map((v) => v / total).toList();

  //   // --- 6️⃣ Convert to gram and prepare output ---
  //   final fertilizerResults = <String, Map<String, double>>{};
  //   for (int i = 0; i < n; i++) {
  //     final weight = normalized[i] * totalWeightGram;
  //     fertilizerResults[
  //         fertilizers[i].fertilizerNameSelected ?? 'Pupuk ${i + 1}'] = {
  //       'weight': double.parse(weight.toStringAsFixed(3)),
  //       'percent': double.parse((normalized[i] * 100).toStringAsFixed(3)),
  //     };
  //   }

  //   // --- 7️⃣ compute total nutrients of mix ---
  //   final totalNutrients = <String, double>{};
  //   for (int i = 0; i < m; i++) {
  //     double totalElem = 0.0;
  //     for (int j = 0; j < n; j++) {
  //       totalElem += (A[i][j] * normalized[j]);
  //     }
  //     totalNutrients[nutrientList[i]] =
  //         double.parse((totalElem * 100).toStringAsFixed(3));
  //   }

  //   return {
  //     'fertilizer_results': fertilizerResults,
  //     'total_weight_gram': totalWeightGram,
  //     'total_nutrients_percent': totalNutrients,
  //   };
  // } // end countWeightFertilizer

  // // Helper: build submatrix from A using selected column indices (preserve row order)
  // static Matrix _buildSubMatrixByColumns(Matrix A, List<int> columns) {
  //   if (columns.isEmpty) {
  //     return Matrix.fromList([[]]); // 0-col matrix (handle with care)
  //   }
  //   final int m = A.rowsNum;
  //   final List<List<double>> rows = List.generate(m, (i) {
  //     return columns.map((c) => A[i][c]).toList();
  //   });
  //   return Matrix.fromList(rows);
  // }

  /// --- Gaussian Elimination helper ---
  // static List<double> _gaussianElimination(
  //     List<List<double>> A, List<double> b) {
  //   final n = A.length;
  //   for (int i = 0; i < n; i++) {
  //     // Pivot
  //     int maxRow = i;
  //     for (int k = i + 1; k < n; k++) {
  //       if (A[k][i].abs() > A[maxRow][i].abs()) maxRow = k;
  //     }
  //     final tmp = A[i];
  //     A[i] = A[maxRow];
  //     A[maxRow] = tmp;
  //     final t = b[i];
  //     b[i] = b[maxRow];
  //     b[maxRow] = t;

  //     // Eliminasi
  //     for (int k = i + 1; k < n; k++) {
  //       double c = -A[k][i] / (A[i][i] + 1e-12);
  //       for (int j = i; j < n; j++) {
  //         if (i == j)
  //           A[k][j] = 0;
  //         else
  //           A[k][j] += c * A[i][j];
  //       }
  //       b[k] += c * b[i];
  //     }
  //   }

  //   // Back substitution
  //   List<double> x = List.filled(n, 0.0);
  //   for (int i = n - 1; i >= 0; i--) {
  //     double sum = b[i];
  //     for (int j = i + 1; j < n; j++) sum -= A[i][j] * x[j];
  //     x[i] = sum / (A[i][i] + 1e-12);
  //   }
  //   return x;
  // }

  // static List<List<double>> _transpose(List<List<double>> matrix) {
  //   int rows = matrix.length;
  //   int cols = matrix[0].length;
  //   return List.generate(cols, (i) => List.generate(rows, (j) => matrix[j][i]));
  // }

  // static List<List<double>> _multiply(
  //     List<List<double>> A, List<List<double>> B) {
  //   int aRows = A.length, aCols = A[0].length, bCols = B[0].length;
  //   return List.generate(
  //       aRows,
  //       (i) => List.generate(
  //           bCols,
  //           (j) => List.generate(aCols, (k) => A[i][k] * B[k][j])
  //               .reduce((a, b) => a + b)));
  // }

  // static List<double> _multiplyVector(List<List<double>> A, List<double> x) {
  //   return List.generate(
  //       A.length,
  //       (i) => List.generate(A[i].length, (j) => A[i][j] * x[j])
  //           .reduce((a, b) => a + b));
  // }

  static List<double> _gaussianElimination(
      List<List<double>> A, List<double> b) {
    int n = A.length;
    for (int i = 0; i < n; i++) {
      double maxEl = A[i][i].abs();
      int maxRow = i;
      for (int k = i + 1; k < n; k++) {
        if (A[k][i].abs() > maxEl) {
          maxEl = A[k][i].abs();
          maxRow = k;
        }
      }
      var temp = A[maxRow];
      A[maxRow] = A[i];
      A[i] = temp;
      double t = b[maxRow];
      b[maxRow] = b[i];
      b[i] = t;

      for (int k = i + 1; k < n; k++) {
        double c = -A[k][i] / A[i][i];
        for (int j = i; j < n; j++) {
          if (i == j) {
            A[k][j] = 0;
          } else {
            A[k][j] += c * A[i][j];
          }
        }
        b[k] += c * b[i];
      }
    }

    List<double> x = List.filled(n, 0.0);
    for (int i = n - 1; i >= 0; i--) {
      x[i] = b[i] / A[i][i];
      for (int k = i - 1; k >= 0; k--) {
        b[k] -= A[k][i] * x[i];
      }
    }
    return x;
  }
}
