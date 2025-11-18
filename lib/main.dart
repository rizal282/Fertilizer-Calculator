import 'package:akurasipupuk/core/config/theme_config.dart';
import 'package:akurasipupuk/features/auth/presentation/page/login_page.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/repositories/fertilizer_repository_impl.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/repositories/rcnaf_repository_impl.dart';
import 'package:akurasipupuk/features/fertilizer/data/percent/repositories/rcnpf_repository_impl.dart';
import 'package:akurasipupuk/features/fertilizer/data/ppm/repositories/ppm_repository_impl.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/repositories/count_weight_by_percent_target_repository_impl.dart';
import 'package:akurasipupuk/features/fertilizer/data/weight/repositories/master_fertilizer_repository_impl.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/fertilizer/fertilizer_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnaf/rcnaf_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/percent/rcnpf/rcnpf_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/ppm/ppm_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/count_weight_by_percent/count_weight_by_percent_bloc.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/bloc/weight/master_fertilizer_weight/master_fertilizer_weight_bloc.dart';
import 'package:akurasipupuk/features/home/presentation/page/home_page.dart';
import 'package:akurasipupuk/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final fertilizerRepoImpl = FertilizerRepositoryImpl();
  final rcnafRepoImpl = RcnafRepositoryImpl();
  final rcnpfRepoImpl = RcnpfRepositoryImpl();
  final masterFertiliers = MasterFertilizerRepositoryImpl();
  final countWeightByPercetTarget = CountWeightByPercentTargetRepositoryImpl();
  final ppmRepositoryIml = PpmRepositoryImpl();

  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(
    isLoggedIn: user != null,
    fertilizerRepository: fertilizerRepoImpl,
    rcnpfRepository: rcnpfRepoImpl,
    rcnafRepository: rcnafRepoImpl,
    masterFertilizerRepositoryImpl: masterFertiliers,
    countWeightByPercentTargetRepositoryImpl: countWeightByPercetTarget,
    ppmRepositoryImpl: ppmRepositoryIml,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final FertilizerRepositoryImpl fertilizerRepository;
  final RcnpfRepositoryImpl rcnpfRepository;
  final RcnafRepositoryImpl rcnafRepository;
  final MasterFertilizerRepositoryImpl masterFertilizerRepositoryImpl;
  final CountWeightByPercentTargetRepositoryImpl
      countWeightByPercentTargetRepositoryImpl;
  final PpmRepositoryImpl ppmRepositoryImpl;

  const MyApp(
      {super.key,
      required this.isLoggedIn,
      required this.fertilizerRepository,
      required this.rcnpfRepository,
      required this.rcnafRepository,
      required this.masterFertilizerRepositoryImpl,
      required this.countWeightByPercentTargetRepositoryImpl,
      required this.ppmRepositoryImpl});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: fertilizerRepository),
        RepositoryProvider.value(value: rcnpfRepository),
        RepositoryProvider.value(value: rcnafRepository),
        RepositoryProvider.value(value: masterFertilizerRepositoryImpl),
        RepositoryProvider.value(
            value: countWeightByPercentTargetRepositoryImpl),
        RepositoryProvider.value(value: ppmRepositoryImpl)
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FertilizerBloc(
                context.read<FertilizerRepositoryImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => RcnpfBloc(
                context.read<RcnpfRepositoryImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => RcnafBloc(
                context.read<RcnafRepositoryImpl>(),
              ),
            ),
            BlocProvider(
                create: (context) => MasterFertilizerWeightBloc(
                    context.read<MasterFertilizerRepositoryImpl>())),
            BlocProvider(
                create: (context) => CountWeightByPercentBloc(
                    context.read<CountWeightByPercentTargetRepositoryImpl>())),
            BlocProvider(
              create: (context) => PpmBloc(context.read<PpmRepositoryImpl>()),
            )
          ],
          child: MaterialApp(
            title: 'Akurasi Pupuk',
            theme: AgricultureTheme.light,
            home: isLoggedIn ? HomePage() : LoginPage(),
          )),
    );
  }
}
