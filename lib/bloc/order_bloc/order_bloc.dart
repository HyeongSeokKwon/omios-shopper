import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/model/orderProduct.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState.initial()) {
    on<AddProductToCartEvent>(addProductToCart);
  }

  void addProductToCart(AddProductToCartEvent event, Emitter<OrderState> emit) {
    emit(
      state.copyWith(productCart: event.orderProduct),
    );
  }
}
