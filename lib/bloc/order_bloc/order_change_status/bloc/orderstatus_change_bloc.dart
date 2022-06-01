import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/model/orderHistoryModel.dart';
import 'package:cloth_collection/repository/orderRepository.dart';
import 'package:cloth_collection/repository/productRepository.dart';
import 'package:equatable/equatable.dart';

part 'orderstatus_change_event.dart';
part 'orderstatus_change_state.dart';

class OrderstatusChangeBloc
    extends Bloc<OrderstatusChangeEvent, OrderstatusChangeState> {
  final OrderRepository _orderRepository = OrderRepository();
  final ProductRepository _productRepository = ProductRepository();
  final ShippingAddressBloc shippingAddressBloc;
  final OrderHistoryBloc orderHistoryBloc;

  OrderstatusChangeBloc(
      {required this.shippingAddressBloc, required this.orderHistoryBloc})
      : super(OrderstatusChangeState.initial()) {
    on<CancelOrderEvent>(cancelOrder);
    on<ChangeShippingAddressEvent>(changeShippingAddress);
    on<ClickChangeOptionEvent>(clickChangeOption);
    on<ChangeOptionEvent>(changeOptions);
  }

  Future<void> cancelOrder(
      CancelOrderEvent event, Emitter<OrderstatusChangeState> emit) async {
    Map response;
    try {
      emit(state.copyWith(cancelOrderState: ApiState.loading));
      response =
          await _orderRepository.cancelOrder(event.orderId, event.itemId);

      emit(state.copyWith(cancelOrderState: ApiState.success));
    } catch (e) {
      emit(state.copyWith(cancelOrderState: ApiState.fail));
    }
  }

  Future<void> changeShippingAddress(ChangeShippingAddressEvent event,
      Emitter<OrderstatusChangeState> emit) async {
    Map response;
    Map body = {};
    try {
      emit(state.copyWith(changeShippingAddressState: ApiState.loading));
      body['name'] = shippingAddressBloc.state.addressKinds;
      body['receiver_name'] = shippingAddressBloc.state.recipient;
      body['mobile_number'] = shippingAddressBloc.state.mobilePhoneNumber;
      body['zip_code'] = shippingAddressBloc.state.zipCode;
      body['base_address'] = shippingAddressBloc.state.baseAddress;
      body['detail_address'] = shippingAddressBloc.state.detailAddress;
      body['shipping_message'] =
          event.orderHistoryData.shippingAddress['shipping_message'];

      response = await _orderRepository.changeShippingAddress(
          event.orderHistoryData.id, body);
      emit(state.copyWith(changeShippingAddressState: ApiState.success));
    } catch (e) {
      emit(state.copyWith(changeShippingAddressState: ApiState.fail));
    }
  }

  Future<void> clickChangeOption(ClickChangeOptionEvent event,
      Emitter<OrderstatusChangeState> emit) async {
    Map productResponse;
    List colorOptions;
    List options = [];
    try {
      emit(state.copyWith(getOptionInfoState: ApiState.loading));
      productResponse =
          await _productRepository.getProductInfo(event.productId);

      colorOptions = productResponse['colors'];
      for (var colorOption in colorOptions) {
        for (var sizeOption in colorOption['options']) {
          if (sizeOption['on_sale']) {
            options.add(
              {
                'color': colorOption['display_color_name'],
                'size': sizeOption['size'],
                'option_id': sizeOption['id']
              },
            );
          }
        }
      }
      emit(state.copyWith(
          getOptionInfoState: ApiState.success, optionList: options));
    } catch (e) {
      emit(state.copyWith(getOptionInfoState: ApiState.fail));
    }
  }

  Future<void> changeOptions(
      ChangeOptionEvent event, Emitter<OrderstatusChangeState> emit) async {
    Map<String, dynamic> changeOptionResponse;

    try {
      emit(state.copyWith(changeOptionState: ApiState.loading));
      changeOptionResponse =
          await _orderRepository.changeOption(event.itemId, event.optionId);
      emit(state.copyWith(changeOptionState: ApiState.success));
      orderHistoryBloc.add(InitOrderHistoryEvent());
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(changeOptionState: ApiState.fail));
    }
  }
}
