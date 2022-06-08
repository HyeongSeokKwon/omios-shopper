import 'package:equatable/equatable.dart';

import '../../bloc.dart';

class CartState extends Equatable {
  final ApiState registToCartState;
  final ApiState getCartsState;
  final ApiState patchCartsState;
  final ApiState deleteCartsState;
  final List getCartsData;
  final List selectedProducts;
  CartState(
      {required this.registToCartState,
      required this.getCartsState,
      required this.patchCartsState,
      required this.deleteCartsState,
      required this.getCartsData,
      required this.selectedProducts});

  factory CartState.initial() {
    return CartState(
      registToCartState: ApiState.initial,
      getCartsState: ApiState.initial,
      patchCartsState: ApiState.initial,
      deleteCartsState: ApiState.initial,
      getCartsData: [],
      selectedProducts: [],
    );
  }

  @override
  List<Object> get props => [
        registToCartState,
        getCartsState,
        patchCartsState,
        deleteCartsState,
        getCartsData,
        selectedProducts
      ];

  CartState copyWith({
    ApiState? registToCartState,
    ApiState? getCartsState,
    ApiState? patchCartsState,
    ApiState? deleteCartsState,
    List? getCartsData,
    List? selectedProducts,
  }) {
    return CartState(
      registToCartState: registToCartState ?? this.registToCartState,
      getCartsState: getCartsState ?? this.getCartsState,
      patchCartsState: patchCartsState ?? this.patchCartsState,
      deleteCartsState: deleteCartsState ?? this.deleteCartsState,
      getCartsData: getCartsData ?? this.getCartsData,
      selectedProducts: selectedProducts ?? this.selectedProducts,
    );
  }
}
