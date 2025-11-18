import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:akurasipupuk/features/auth/presentation/bloc/login_bloc.dart';
import 'package:akurasipupuk/features/auth/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF3C8D40)),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SvgPicture.asset(
                  StringConst.imageAppHome,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Selamat datang di Aplikasi Akurasi Pupuk",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),
              // Text("Masuk untuk mulai menggunakan:", textAlign: TextAlign.center),
              // SizedBox(height: 12,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginWithGoogleEvent());
                  },
                  child: Text(
                    "@ Masuk dengan Google",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
