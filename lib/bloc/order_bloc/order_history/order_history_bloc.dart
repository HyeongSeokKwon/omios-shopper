import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/orderRepository.dart';
import 'package:equatable/equatable.dart';

import '../../../model/orderHistoryModel.dart';
import '../../../page/orderHistory/orderHistory.dart';
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
    Map<String, dynamic> response;
    List<OrderHistoryData> orderHistoryList;

    try {
      emit(state.copyWith(getOrderHistoryState: ApiState.loading));
      response = await _orderRepository.getOrderHistory();
      orderHistoryList = List.generate(
        response['data'].length,
        (index) {
          return OrderHistoryData.from(response['data'][index]);
        },
      );

      emit(
        state.copyWith(
          getOrderHistoryState: ApiState.success,
          orderHistoryList: orderHistoryList,
        ),
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

      emit(state.copyWith(
          getOrderHistoryState: ApiState.success,
          orderHistory: OrderHistoryData.from(response)));
    } catch (e) {
      emit(state.copyWith(getOrderHistoryState: ApiState.fail));
    }
  }
}
