part of 'auth_bloc.dart';

class AuthState<T> {
  final AuthReact react;

  final AuthModel? auth;

  AuthState({
    this.react = AuthReact.initial,
    this.auth,
  });

  AuthState<T> copyWith(
    AuthState state, {
    AuthReact? react,
    AuthModel? auth,
  }) =>
      AuthState<T>(
        react: react ?? state.react,
        auth: auth ?? state.auth,
      );
}

enum AuthReact {
  initial,
  getLoading,
  getSuccess,
  getError,

  postLoading,
  postSuccess,
  postError,

  closeLoading,
  closeSuccess,
  closeError,
}
