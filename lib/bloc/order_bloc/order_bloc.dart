import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/model/orderProduct.dart';
import 'package:cloth_collection/repository/orderRepository.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  late ShippingAddressBloc shippingAddressBloc;
  late ShopperInfoBloc shopperInfoBloc;
  final OrderRepository _orderRepository = OrderRepository();
  OrderBloc() : super(OrderState.initial()) {
    on<AddProductToCartEvent>(addProductToCart);
    on<RegistOrderEvent>(registOrder);
    on<CalculatePriceInfoEvent>(calculatePriceInfo);
    on<ChangeUsingPointEvent>(usingPoint);
  }

  void usingPoint(ChangeUsingPointEvent event, Emitter<OrderState> emit) {
    if (event.point.isEmpty) {
      emit(state.copyWith(usedPoint: 0));
      return;
    }
    emit(state.copyWith(usedPoint: int.parse(event.point)));
  }

  void calculatePriceInfo(
      CalculatePriceInfoEvent event, Emitter<OrderState> emit) {
    final membershipDiscountRate = double.parse(
        shopperInfoBloc.state.shopperInfo['membership']['discount_rate']);

    int baseDiscountPrice;
    int totalProductPrice = 0;
    int baseDiscountedPrice = 0;
    int membershipDiscountPrice = 0;

    for (OrderProduct value in state.productCart) {
      totalProductPrice += value.salePrice * value.count;
      baseDiscountedPrice += value.baseDiscountedPrice * value.count;
      membershipDiscountPrice +=
          (value.baseDiscountedPrice * (membershipDiscountRate / 100)).toInt() *
              value.count;
    }
    baseDiscountPrice = totalProductPrice - baseDiscountedPrice;

    emit(
      state.copyWith(
          baseDiscountPrice: baseDiscountPrice,
          totalProductPrice: totalProductPrice,
          membershipDiscountPrice: membershipDiscountPrice,
          finalPaymentPrice: totalProductPrice -
              baseDiscountPrice -
              state.usedPoint -
              membershipDiscountPrice),
    );
    emit(state.copyWith(
        canUsePoint: state.totalProductPrice -
            membershipDiscountPrice -
            baseDiscountPrice -
            1000));
  }

  void addProductToCart(AddProductToCartEvent event, Emitter<OrderState> emit) {
    emit(
      state.copyWith(
        productCart: event.orderProduct,
      ),
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
        shippingAddressBloc.state.requirement == "직접 입력"
            ? event.requirement
            : shippingAddressBloc.state.requirement.isEmpty
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
                  (double.parse(shopperInfoBloc.state.shopperInfo['membership']
                          ['discount_rate']) /
                      100))
              .toInt() *
          value.count;

      item['payment_price'] =
          (item['base_discounted_price'] - item['membership_discount_price']);

      items.add(item);
      totalPrice += item['payment_price'] as int;
    }
    body['items'] = items;

    body['actual_payment_price'] =
        totalPrice.toInt() - state.usedPoint; //결제할 금액
    body['used_point'] = state.usedPoint;
    body['earned_point'] = (body['actual_payment_price'] * 0.01).toInt();

    try {
      emit(state.copyWith(registOrderState: ApiState.loading));
      response = await _orderRepository.postOrder(body);
      if (response['code'] == 201) {
        emit(state.copyWith(
            registOrderState: ApiState.success,
            orderId: response['data']['id']));
      }
    } catch (e) {
      emit(state.copyWith(registOrderState: ApiState.fail));
    }

    emit(state.copyWith());
  }
}
