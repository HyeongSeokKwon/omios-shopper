import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/model/orderProduct.dart';
import 'package:cloth_collection/repository/orderRepository.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  late final ShippingAddressBloc shippingAddressBloc;
  late final ShopperInfoBloc shopperInfoBloc;
  final OrderRepository _orderRepository = OrderRepository();
  OrderBloc() : super(OrderState.initial()) {
    on<AddProductToCartEvent>(addProductToCart);
    on<RegistOrderEvent>(registOrder);
  }

  void addProductToCart(AddProductToCartEvent event, Emitter<OrderState> emit) {
    emit(
      state.copyWith(productCart: event.orderProduct),
    );
  }

  Future<void> registOrder(
      RegistOrderEvent event, Emitter<OrderState> emit) async {
    Map<String, dynamic> shippingAddress = {};
    List<Map> items = [];
    Map<String, dynamic> body = {};
    Map<String, dynamic> response;
    int totalPrice = 0;

    shippingAddress['receiver_name'] = shippingAddressBloc.state.recipient;
    shippingAddress['mobile_number'] =
        shippingAddressBloc.state.mobilePhoneNumber;
    shippingAddress['phone_number'] =
        shippingAddressBloc.state.phoneNumber.isEmpty
            ? null
            : shippingAddressBloc.state.phoneNumber;
    shippingAddress['zip_code'] = shippingAddressBloc.state.zipCode;
    shippingAddress['base_address'] = shippingAddressBloc.state.baseAddress;
    shippingAddress['detail_address'] = shippingAddressBloc.state.detailAddress;
    shippingAddress['shipping_message'] =
        shippingAddressBloc.state.requirement.isEmpty
            ? "없음"
            : shippingAddressBloc.state.requirement;

    body['shipping_address'] = shippingAddress;

    for (var value in state.productCart) {
      Map item = {};
      item['option'] = value.optionId;
      item['base_discounted_price'] = value.baseDiscountedPrice * value.count;
      item['count'] = value.count;
      item['sale_price'] = value.salePrice * value.count;
      item['membership_discount_price'] = (value.baseDiscountedPrice *
                  (shopperInfoBloc.state.shopperInfo['membership']
                          ['discount_rate'] /
                      100))
              .toInt() *
          value.count;

      // print(value.baseDiscountedPrice);
      // print(item['membership_discount_price'] = (value.baseDiscountedPrice *
      //         ((100 -
      //                 shopperInfoBloc.state.shopperInfo['membership']
      //                     ['discount_rate']) /
      //             100))
      //     .toInt());
      item['payment_price'] =
          (item['base_discounted_price'] - item['membership_discount_price']);

      items.add(item);
      totalPrice += item['payment_price'] as int;
    }
    print(totalPrice);
    body['items'] = items;

    body['actual_payment_price'] = totalPrice.toInt(); //결제할 금액
    body['used_point'] = 0;
    body['earned_point'] = (totalPrice * 0.01).toInt();
    print(body);

    try {
      emit(state.copyWith(registOrderState: ApiState.loading));
      response = await _orderRepository.postOrder(body);
      emit(state.copyWith(registOrderState: ApiState.success));
    } catch (e) {
      emit(state.copyWith(registOrderState: ApiState.fail));
    }

    emit(state.copyWith());
  }
}