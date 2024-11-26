import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/features/consumable/models/impresora_model.dart';
import 'package:muni_stock/features/consumable/repository/consmable_repository.dart';

part 'consumable_event.dart';
part 'consumable_state.dart';

typedef React = ConsumableReact;
typedef Emit = Emitter<ConsumableState>;

class ConsumableBloc extends Bloc<ConsumableEvent, ConsumableState> {
  final ConsmableRepository api;
  ConsumableBloc(this.api) : super(ConsumableState()) {
    on<LoadConsumableEvent>((event, emit) async {
      emit(ConsumableState().copyWith(state, react: React.getLoading));
      await onLoadConsumables(event, emit);
    });
  }

  Future<void> onLoadConsumables(LoadConsumableEvent evt, Emit emit) async {
    try {
      final list = await api.getAll();

      emit(
        ConsumableState().copyWith(
          state,
          impresoras: list,
          filterconsumables: list,
          react: React.getSuccess,
        ),
      );
    } catch (e) {
      // Transmitir un estado a la vista/pantalla/pagina/
      emit(ConsumableState().copyWith(state, react: React.getError));
    }
  }
}
