part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class DataLoading extends LoginState {}

class DataSuccess extends LoginState {
  final List<AuthResponse> data;
  DataSuccess(this.data);
}

class DataFailure extends LoginState {
  final String error;
  DataFailure(this.error);
}