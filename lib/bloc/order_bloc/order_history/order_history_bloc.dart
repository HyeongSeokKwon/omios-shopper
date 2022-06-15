import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/orderRepository.dart';
import 'package:equatable/equatable.dart';

import '../../../model/orderHistoryModel.dart';
import '../../bloc.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderRepository _orderRepository = OrderRepository();
  OrderHistoryBloc() : super(OrderHistoryState.initial()) {
    on<OrderHistoryEvent>(initOrderHistory);
    on<ChangeStartTimeEvent>(changeStartTime);
    on<ChangeEndTimeEvent>(changeEndTime);
    on<GetOrderHistoryByIdEvent>(getOrderHistoryById);
  }

  Future<void> initOrderHistory(
      OrderHistoryEvent event, Emitter<OrderHistoryState> emit) async {
    Map<String, dynamic> orderHistoryResponse;
    List orderStatisticsResponse;
    List<OrderHistoryData> orderHistoryList;

    try {
      emit(state.copyWith(getOrderHistoryState: ApiState.loading));
      orderHistoryResponse = await _orderRepository.getOrderHistory();
      orderStatisticsResponse = await _orderRepository.getOrderStatistics();

      orderHistoryList = List.generate(
        orderHistoryResponse['data'].length,
        (index) {
          return OrderHistoryData.from(orderHistoryResponse['data'][index]);
        },
      );

      emit(
        state.copyWith(
            getOrderHistoryState: ApiState.success,
            orderHistoryList: orderHistoryList,
            orderStatistics: orderStatisticsResponse),
      );
    } catch (e) {
      emit(state.copyWith(getOrderHistoryState: ApiState.fail));
    }
    // 주문 내역 가져오기
  }

  void changeStartTime(
      ChangeStartTimeEvent event, Emitter<OrderHistoryState> emit) {
    emit(state.copyWith(start: event.startTime));
  }

  void changeEndTime(
      ChangeEndTimeEvent event, Emitter<OrderHistoryState> emit) {
    print("*******");
    print(event.endTime);
    emit(state.copyWith(end: event.endTime));
    print(state.end);
  }

  Future<void> getOrderHistoryById(
      GetOrderHistoryByIdEvent event, Emitter<OrderHistoryState> emit) async {
    Map<String, dynamic> response;

    try {
      emit(state.copyWith(getOrderHistoryState: ApiState.loading));

      response = await _orderRepository.getOrderHistoryById(event.orderId);
      print(response);
      emit(state.copyWith(
        getOrderHistoryState: ApiState.success,
        orderHistory: OrderHistoryData.from(response),
      ));
      emit(state.copyWith(orderDetailPriceInfo: calculateTotalPrice()));
    } catch (e) {
      emit(state.copyWith(getOrderHistoryState: ApiState.fail));
    }
  }

  Map calculateTotalPrice() {
    int totalCouponDiscountedPrice = 0; //총 쿠폰할인
    int totalMembershipDiscountedPrice = 0; //총 멤버십 할인
    int totalProductPrice = 0; //총 상품 가격
    int totalBaseDiscountedPrice = 0; //총 상품 기본할인
    int totalPaymentPrice = 0; //총 결제금액
    int totalDiscountedPrice = 0; //총 할인 금액

    for (var value in state.orderHistory!.items) {
      totalCouponDiscountedPrice += 0;
      totalMembershipDiscountedPrice += value.membershipDiscountPrice;
      totalProductPrice += value.salePrice;
      totalBaseDiscountedPrice += value.baseDiscountPrice;
      totalPaymentPrice += value.paymentPrice;
    }

    totalDiscountedPrice = totalCouponDiscountedPrice +
        totalMembershipDiscountedPrice +
        totalBaseDiscountedPrice;

    return {
      'total_coupon_discounted_price': totalCouponDiscountedPrice,
      'total_membership_discounted_price': totalMembershipDiscountedPrice,
      'total_product_price': totalProductPrice,
      'total_base_discounted_price': totalBaseDiscountedPrice,
      'total_payment_price': totalPaymentPrice,
      'total_discounted_price': totalDiscountedPrice,
      'total_discount_rate':
          ((totalDiscountedPrice / totalProductPrice) * 100).round()
    };
  }
}
