import 'package:get_it/get_it.dart';
import 'package:muni_stock/features/auth/bloc/auth_bloc.dart';
import 'package:muni_stock/features/auth/repository/auth_repository.dart';
import 'package:muni_stock/features/consumable/bloc/consumable_bloc.dart';
import 'package:muni_stock/features/consumable/repository/consmable_repository.dart';

final sl = GetIt.instance;

Future<void> injection() async {
  sl.registerSingleton<AuthRepository>(AuthRepository());
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
  // Consumable
  sl.registerSingleton<ConsmableRepository>(ConsmableRepository());
  sl.registerFactory<ConsumableBloc>(() => ConsumableBloc(sl()));
}
