part of 'consumable_bloc.dart';

class ConsumableState<T> {
  final ConsumableReact react;
  final List<Object>? consumables;
  final List<Object>? filterConsumables;
  final Object? consumable;

  ConsumableState({
    this.react = ConsumableReact.initial,
    this.consumables = const [],
    this.filterConsumables = const [],
    this.consumable,
  });

  ConsumableState<T> copyWith(
    ConsumableState state, {
    ConsumableReact? react,
    List<Object>? consumables,
    List<Object>? filterconsumables,
    Object? consumable,
  }) =>
      ConsumableState<T>(
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
