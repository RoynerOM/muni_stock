part of 'consumable_bloc.dart';

class ConsumableState {
  final ConsumableReact react;
  final List<ImpresoraModel> impresoras;
  final List<ImpresoraModel> filterConsumables;
  final ImpresoraModel? impresora;

  ConsumableState({
    this.react = ConsumableReact.initial,
    this.impresoras = const [],
    this.filterConsumables = const [],
    this.impresora,
  });

  ConsumableState copyWith(
    ConsumableState state, {
    ConsumableReact? react,
    List<ImpresoraModel>? impresoras,
    List<ImpresoraModel>? filterconsumables,
    ImpresoraModel? consumable,
  }) =>
      ConsumableState(
        react: react ?? state.react,
        impresoras: impresoras ?? state.impresoras,
        filterConsumables: filterconsumables ?? state.filterConsumables,
        impresora: consumable ?? state.impresora,
      );
}

enum ConsumableReact {
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
