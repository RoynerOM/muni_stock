import 'package:flutter_bloc/flutter_bloc.dart';

part 'consumable_event.dart';
part 'consumable_state.dart';

class ConsumableBloc extends Bloc<ConsumableEvent, ConsumableState> {
  ConsumableBloc() : super(ConsumableState()) {
    on<ConsumableEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
