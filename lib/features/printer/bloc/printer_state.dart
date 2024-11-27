part of 'printer_bloc.dart';

class PrinterState {
  final PrinterReact react;
  final List<ImpresoraModel> printers;
  final List<ImpresoraModel> filterPrinters;
  final ImpresoraModel? impresora;

  PrinterState({
    this.react = PrinterReact.initial,
    this.printers = const [],
    this.filterPrinters = const [],
    this.impresora,
  });

  PrinterState copyWith(
    PrinterState state, {
    PrinterReact? react,
    List<ImpresoraModel>? printers,
    List<ImpresoraModel>? filterPrinters,
    ImpresoraModel? consumable,
  }) =>
      PrinterState(
        react: react ?? state.react,
        printers: printers ?? state.printers,
        filterPrinters: filterPrinters ?? state.filterPrinters,
        impresora: consumable ?? state.impresora,
      );
}

enum PrinterReact {
  initial,
  getLoading,
  getSuccess,
  getError,

  postLoading,
  postSuccess,
  postError,

  updateLoading,
  updateSuccess,
  updateError,

  deleteLoading,
  deleteSuccess,
  deleteError,
}
