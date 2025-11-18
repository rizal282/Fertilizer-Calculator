import 'package:akurasipupuk/features/auth/domain/usecase/google_sign_in_usecase.dart';
import 'package:akurasipupuk/features/auth/presentation/bloc/login_event.dart';
import 'package:akurasipupuk/features/auth/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
  }

  Future<void> _onLoginWithGoogle(LoginWithGoogleEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final user = await GoogleSignInUsecase.signInWithGoogle();

    if(user != null){
      emit(LoginSuccess());
    }else {
      emit(LoginFailure("Gagal melakukan login"));
    }
  }

}