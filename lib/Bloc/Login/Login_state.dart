// lib/bloc/auth_state.dart

part of 'Login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends LoginState {}

class AuthLoading extends LoginState {}

class AuthAuthenticated extends LoginState {}

class AuthError extends LoginState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
