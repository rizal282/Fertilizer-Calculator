import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfg_app/features/fertilizer/data/repositories/fertilizer_repository_impl.dart';
import 'package:pfg_app/features/fertilizer/data/repositories/rcnaf_repository_impl.dart';
import 'package:pfg_app/features/fertilizer/data/repositories/rcnpf_repository_impl.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/fertilizer/fertilizer_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnaf/rcnaf_bloc.dart';
import 'package:pfg_app/features/fertilizer/presentation/bloc/rcnpf/rcnpf_bloc.dart';
import 'package:pfg_app/features/home/presentation/page/home_page.dart';

void main() {
  final fertilizerRepoImpl = FertilizerRepositoryImpl();
  final rcnafRepoImpl = RcnafRepositoryImpl();
  final rcnpfRepoImpl = RcnpfRepositoryImpl();

  runApp(MyApp(
    fertilizerRepository: fertilizerRepoImpl,
    rcnpfRepository: rcnpfRepoImpl,
    rcnafRepository: rcnafRepoImpl,
  ));
}

class MyApp extends StatelessWidget {
  final FertilizerRepositoryImpl fertilizerRepository;
  final RcnpfRepositoryImpl rcnpfRepository;
  final RcnafRepositoryImpl rcnafRepository;

  const MyApp(
      {super.key,
      required this.fertilizerRepository,
      required this.rcnpfRepository,
      required this.rcnafRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: fertilizerRepository),
        RepositoryProvider.value(value: rcnpfRepository),
        RepositoryProvider.value(value: rcnafRepository),
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
            )
          ],
          child: MaterialApp(
            title: 'PFG App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blueAccent,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20, // <-- ukuran font standar AppBar
                  fontWeight: FontWeight.w600, // (opsional) supaya lebih tegas
                ),
              ),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }),
            ),
            home: HomePage(),
          )),
    );
  }
}
