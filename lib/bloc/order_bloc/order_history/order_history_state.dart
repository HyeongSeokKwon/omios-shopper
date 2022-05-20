part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  final List<Map<String, dynamic>> orderHistoryList;
  final ApiState getOrderHistoryState;
  OrderHistoryState({
    required this.orderHistoryList,
    required this.getOrderHistoryState,
  });

  factory OrderHistoryState.initial() {
    return OrderHistoryState(
      orderHistoryList: [],
      getOrderHistoryState: ApiState.initial,
    );
  }

  @override
  List<Object> get props => [orderHistoryList, getOrderHistoryState];

  OrderHistoryState copyWith({
    List<Map<String, dynamic>>? orderHistoryList,
    ApiState? getOrderHistoryState,
  }) {
    return OrderHistoryState(
      orderHistoryList: orderHistoryList ?? this.orderHistoryList,
      getOrderHistoryState: getOrderHistoryState ?? this.getOrderHistoryState,
    );
  }
}
