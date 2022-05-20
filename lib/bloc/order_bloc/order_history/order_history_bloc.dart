import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/orderRepository.dart';
import 'package:equatable/equatable.dart';

import '../../bloc.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderRepository _orderRepository = OrderRepository();
  OrderHistoryBloc() : super(OrderHistoryState.initial()) {
    on<OrderHistoryEvent>(initOrderHistory);
  }

  Future<void> initOrderHistory(
      OrderHistoryEvent event, Emitter<OrderHistoryState> emit) async {
    Map response;
    response = await _orderRepository.getOrderHistory();
    // 주문 내역 가져오기
  }
}
