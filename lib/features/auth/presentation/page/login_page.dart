import 'package:akurasipupuk/features/auth/presentation/bloc/login_bloc.dart';
import 'package:akurasipupuk/features/auth/presentation/bloc/login_state.dart';
import 'package:akurasipupuk/features/auth/presentation/widget/login_view.dart';
import 'package:akurasipupuk/features/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              ),
            );
          }

          if (state is LoginSuccess) {
            Navigator.of(context).pop(); // tutup loading
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          }

          if (state is LoginFailure) {
            Navigator.of(context).pop(); // tutup loading

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: LoginView(),
      ),
    );
  }
}
