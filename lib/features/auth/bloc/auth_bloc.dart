import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/core/storage/shared_preferences.dart';
import 'package:muni_stock/features/auth/models/auth_model.dart';
import 'package:muni_stock/features/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

typedef Emit = Emitter<AuthState>;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthState(react: AuthReact.initial)) {
    on<ChechSesionEvent>((event, emit) async {
      if (AppStorage().userToken.isNotEmpty) {
        emit(AuthState(react: AuthReact.getSuccess));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthState(react: AuthReact.getLoading));
      await onLogin(event, emit);
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthState(react: AuthReact.postLoading));
      await onRegister(event, emit);
    });

    on<CloseSesionEvent>((event, emit) async {
      AppStorage().clear();
      emit(AuthState(react: AuthReact.postLoading));
    });
  }

  Future<void> onLogin(LoginEvent evt, Emit emit) async {
    final token = await repository.login(evt.model);
    if (token == null) {
      emit(AuthState(react: AuthReact.getError));
    }
    AppStorage().userEmail = evt.model.email;
    AppStorage().userToken = token!;
    emit(AuthState(react: AuthReact.getSuccess));
  }

  Future<void> onRegister(RegisterEvent evt, Emit emit) async {
    try {
      await repository.regsiter(evt.model);
      emit(AuthState(react: AuthReact.postSuccess));
    } catch (e) {
      emit(AuthState(react: AuthReact.postError));
    }
  }
}
