import 'package:equatable/equatable.dart';

import '../../bloc.dart';

class CartState extends Equatable {
  final ApiState registToCartState;
  final ApiState getCartsState;
  final ApiState patchCartsState;
  final ApiState deleteCartsState;
  final List getCartsData;
  CartState({
    required this.registToCartState,
    required this.getCartsState,
    required this.patchCartsState,
    required this.deleteCartsState,
    required this.getCartsData,
  });

  factory CartState.initial() {
    return CartState(
      registToCartState: ApiState.initial,
      getCartsState: ApiState.initial,
      patchCartsState: ApiState.initial,
      deleteCartsState: ApiState.initial,
      getCartsData: [],
    );
  }

  @override
  List<Object> get props => [
        registToCartState,
        getCartsState,
        patchCartsState,
        deleteCartsState,
        getCartsData
      ];

  CartState copyWith({
    ApiState? registToCartState,
    ApiState? getCartsState,
    ApiState? patchCartsState,
    ApiState? deleteCartsState,
    List? getCartsData,
  }) {
    return CartState(
      registToCartState: registToCartState ?? this.registToCartState,
      getCartsState: getCartsState ?? this.getCartsState,
      patchCartsState: patchCartsState ?? this.patchCartsState,
      deleteCartsState: deleteCartsState ?? this.deleteCartsState,
      getCartsData: getCartsData ?? this.getCartsData,
    );
  }
}
