import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/features/printer/models/impresora_model.dart';
import 'package:muni_stock/features/printer/repository/printer_repository.dart';

part 'printer_event.dart';
part 'printer_state.dart';

typedef React = PrinterReact;
typedef Emit = Emitter<PrinterState>;

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  final PrinterRepository api;
  PrinterBloc(this.api) : super(PrinterState()) {
    on<LoadPrinterEvent>((event, emit) async {
      emit(PrinterState().copyWith(state, react: React.getLoading));
      await onLoadPrinters(event, emit);
    });

    on<PostPrinterEvent>((event, emit) async {
      emit(PrinterState().copyWith(state, react: React.postLoading));
      await onPostPrinter(event, emit);
    });

    on<DeletePrinterEvent>((event, emit) async {
      emit(PrinterState().copyWith(state, react: React.deleteLoading));
      await onDeletePrinter(event, emit);
    });
  }

  Future<void> onLoadPrinters(LoadPrinterEvent evt, Emit emit) async {
    try {
      final list = await api.getAll();

      emit(
        PrinterState().copyWith(
          state,
          printers: list,
          filterPrinters: list,
          react: React.getSuccess,
        ),
      );
    } catch (e) {
      emit(PrinterState().copyWith(state, react: React.getError));
    }
  }

  Future<void> onPostPrinter(PostPrinterEvent evt, Emit emit) async {
    try {
      final list = await api.post(evt.model);
      if (list) {
        emit(PrinterState().copyWith(state, react: React.postSuccess));
        add(LoadPrinterEvent());
      } else {
        emit(PrinterState().copyWith(state, react: React.postError));
      }
    } catch (e) {
      emit(PrinterState().copyWith(state, react: React.postError));
    }
  }

  Future<void> onDeletePrinter(DeletePrinterEvent evt, Emit emit) async {
    try {
      final list = await api.delete(evt.serie);
      if (list) {
        emit(PrinterState().copyWith(state, react: React.deleteSuccess));
        add(LoadPrinterEvent());
      } else {
        emit(PrinterState().copyWith(state, react: React.deleteError));
      }
    } catch (e) {
      emit(PrinterState().copyWith(state, react: React.deleteError));
    }
  }
}
