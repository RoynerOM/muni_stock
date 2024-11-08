part of 'consumable_bloc.dart';

class ConsumableState {
  final ConsumableReact react;
  final List<ConsumableModel> consumables;
  final List<ConsumableModel> filterConsumables;
  final ConsumableModel? consumable;

  ConsumableState({
    this.react = ConsumableReact.initial,
    this.consumables = const [],
    this.filterConsumables = const [],
    this.consumable,
  });

  ConsumableState copyWith(
    ConsumableState state, {
    ConsumableReact? react,
    List<ConsumableModel>? consumables,
    List<ConsumableModel>? filterconsumables,
    ConsumableModel? consumable,
  }) =>
      ConsumableState(
        react: react ?? state.react,
        consumables: consumables ?? state.consumables,
        filterConsumables: filterconsumables ?? state.filterConsumables,
        consumable: consumable ?? state.consumable,
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
