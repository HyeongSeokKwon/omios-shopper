import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:cloth_collection/repository/orderRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../model/orderHistoryModel.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderRepository _orderRepository = OrderRepository();
  final HttpRepository _httpRepository = HttpRepository();
  InfinityScrollBloc infinityScrollBloc = InfinityScrollBloc();

  OrderHistoryBloc() : super(OrderHistoryState.initial()) {
    on<InitOrderHistoryEvent>(initOrderHistory);
    on<ChangeStartTimeEvent>(changeStartTime);
    on<ChangeEndTimeEvent>(changeEndTime);
    on<GetOrderHistoryByIdEvent>(getOrderHistoryById);
    on<GetOrderHistoryByDateEvent>(getOrderHistoryByDate);
    on<PagenationEvent>(pagenation);
  }

  Future<void> initOrderHistory(
      InitOrderHistoryEvent event, Emitter<OrderHistoryState> emit) async {
    Map<String, dynamic> orderHistoryResponse;
    List orderStatisticsResponse;
    List<OrderHistoryData> orderHistoryList;
    try {
      orderHistoryResponse = await _orderRepository.getOrderHistory();
      orderStatisticsResponse = await _orderRepository.getOrderStatistics();
      infinityScrollBloc.state.getData = orderHistoryResponse;
      orderHistoryList = List.generate(
        orderHistoryResponse['data']['results'].length,
        (index) {
          return OrderHistoryData.from(
              orderHistoryResponse['data']['results'][index]);
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

  Future<void> pagenation(
      PagenationEvent event, Emitter<OrderHistoryState> emit) async {
    Map<String, dynamic> orderHistoryResponse;
    List<OrderHistoryData> orderHistoryList;
    if (infinityScrollBloc.state.getData['data']['next'] != null) {
      try {
        Uri url = Uri.parse(infinityScrollBloc.state.getData['data']['next']);

        orderHistoryResponse =
            await _httpRepository.httpGet(url.path, url.queryParameters);

        orderHistoryList = List.generate(
          orderHistoryResponse['data']['results'].length,
          (index) {
            return OrderHistoryData.from(
                orderHistoryResponse['data']['results'][index]);
          },
        );
        infinityScrollBloc.state.getData = orderHistoryResponse;
        emit(state.copyWith(
            getOrderHistoryState: ApiState.success,
            orderHistoryList: List.of(state.orderHistoryList)
              ..addAll(orderHistoryList)));
      } catch (e) {
        emit(state.copyWith(getOrderHistoryState: ApiState.fail));
      }
    }
  }

  void changeStartTime(
      ChangeStartTimeEvent event, Emitter<OrderHistoryState> emit) {
    if (state.end.toString().isNotEmpty &&
        state.end!.isBefore(event.startTime!)) {
      emit(state.copyWith(start: state.end, end: event.startTime));
      return;
    }
    emit(state.copyWith(start: event.startTime));
  }

  void changeEndTime(
      ChangeEndTimeEvent event, Emitter<OrderHistoryState> emit) {
    if (state.start.toString().isNotEmpty &&
        state.start!.isAfter(event.endTime!)) {
      emit(state.copyWith(start: state.end, end: event.endTime));
      return;
    }
    emit(state.copyWith(end: event.endTime));
  }

  Future<void> getOrderHistoryById(
      GetOrderHistoryByIdEvent event, Emitter<OrderHistoryState> emit) async {
    Map<String, dynamic> response;

    try {
      emit(state.copyWith(getOrderHistoryState: ApiState.loading));

      response = await _orderRepository.getOrderHistoryById(event.orderId);

      emit(state.copyWith(
        getOrderHistoryState: ApiState.success,
        orderHistory: OrderHistoryData.from(response),
      ));
      emit(state.copyWith(orderDetailPriceInfo: calculateTotalPrice()));
    } catch (e) {
      emit(state.copyWith(getOrderHistoryState: ApiState.fail));
    }
  }

  Future<void> getOrderHistoryByDate(
      GetOrderHistoryByDateEvent event, Emitter<OrderHistoryState> emit) async {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    Map<String, dynamic> orderHistoryResponse;
    List<OrderHistoryData> orderHistoryList;
    try {
      emit(state.copyWith(getOrderHistoryState: ApiState.loading));
      print(formatter.format(state.start!).toString());
      print(formatter.format(state.end!).toString());
      orderHistoryResponse = await _orderRepository.getOrderHistoryByDate(
          formatter.format(state.start!).toString(),
          formatter.format(state.end!).toString());
      print(orderHistoryResponse);
      infinityScrollBloc.state.getData = orderHistoryResponse;
      orderHistoryList = List.generate(
        orderHistoryResponse['data']['results'].length,
        (index) {
          return OrderHistoryData.from(
              orderHistoryResponse['data']['results'][index]);
        },
      );
      print(orderHistoryList);
      emit(state.copyWith(
          getOrderHistoryState: ApiState.success,
          orderHistoryList: orderHistoryList));
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
