import 'package:equatable/equatable.dart';

import '../../../model/orderProduct.dart';
import '../../bloc.dart';

class CartState extends Equatable {
  final ApiState registToCartState;
  final ApiState getCartsState;
  final ApiState patchCartsState;
  final ApiState deleteCartsState;
  final Map getCartsResponse;
  final List getCartsData;
  final List<int> selectedProductsId;
  final List<OrderProduct> selectedProduct;
  CartState({
    required this.registToCartState,
    required this.getCartsState,
    required this.patchCartsState,
    required this.deleteCartsState,
    required this.getCartsResponse,
    required this.getCartsData,
    required this.selectedProductsId,
    required this.selectedProduct,
  });

  factory CartState.initial() {
    return CartState(
      registToCartState: ApiState.initial,
      getCartsState: ApiState.initial,
      patchCartsState: ApiState.initial,
      deleteCartsState: ApiState.initial,
      getCartsResponse: {},
      getCartsData: [],
      selectedProductsId: [],
      selectedProduct: [],
    );
  }

  @override
  List<Object> get props => [
        registToCartState,
        getCartsState,
        patchCartsState,
        deleteCartsState,
        getCartsResponse,
        getCartsData,
        selectedProductsId,
        selectedProduct,
      ];

  CartState copyWith({
    ApiState? registToCartState,
    ApiState? getCartsState,
    ApiState? patchCartsState,
    ApiState? deleteCartsState,
    Map? getCartsResponse,
    List? getCartsData,
    List<int>? selectedProductsId,
    List<OrderProduct>? selectedProduct,
  }) {
    return CartState(
      registToCartState: registToCartState ?? this.registToCartState,
      getCartsState: getCartsState ?? this.getCartsState,
      patchCartsState: patchCartsState ?? this.patchCartsState,
      deleteCartsState: deleteCartsState ?? this.deleteCartsState,
      getCartsResponse: getCartsResponse ?? this.getCartsResponse,
      getCartsData: getCartsData ?? this.getCartsData,
      selectedProductsId: selectedProductsId ?? this.selectedProductsId,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}
