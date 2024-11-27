import 'package:get_it/get_it.dart';
import 'package:muni_stock/features/auth/bloc/auth_bloc.dart';
import 'package:muni_stock/features/auth/repository/auth_repository.dart';
import 'package:muni_stock/features/printer/bloc/printer_bloc.dart';
import 'package:muni_stock/features/printer/repository/printer_repository.dart';

final sl = GetIt.instance;

Future<void> injection() async {
  sl.registerSingleton<AuthRepository>(AuthRepository());
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
  // Consumable
  sl.registerSingleton<PrinterRepository>(PrinterRepository());
  sl.registerFactory<PrinterBloc>(() => PrinterBloc(sl()));
}
