// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopshy/Repository/Login_repository.dart';

part 'Login_event.dart';
part 'Login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository authRepository;

  LoginBloc({required this.authRepository}) : super(AuthInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final success =
            await authRepository.login(event.username, event.password);
        if (success) {
          emit(AuthAuthenticated());
        } else {
          emit(const AuthError(message: 'Login Failed'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
