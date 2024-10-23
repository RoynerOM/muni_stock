part of 'auth_bloc.dart';

abstract class AuthEvent {}

class ChechSesionEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final AuthModel model;
  LoginEvent(this.model);
}

class RegisterEvent extends AuthEvent {
  final AuthModel model;
  RegisterEvent(this.model);
}
