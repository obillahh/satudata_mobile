part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final ResponseLogin login;

  const LoginSuccess({required this.login});

  @override
  List<Object?> get props => [login];
}

class LoginError extends LoginState {
  final String error;

  const LoginError({required this.error});

  @override
  List<Object?> get props => [error];
}
