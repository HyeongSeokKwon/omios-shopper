part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  final List<OrderHistoryData> orderHistoryList;
  final DateTime? start;
  final DateTime? end;
  final ApiState getOrderHistoryState;
  final OrderHistoryData? orderHistory;

  OrderHistoryState({
    required this.orderHistoryList,
    this.start,
    this.end,
    required this.getOrderHistoryState,
    required this.orderHistory,
  });

  factory OrderHistoryState.initial() {
    return OrderHistoryState(
      orderHistoryList: [],
      start: DateTime(0),
      end: DateTime(0),
      getOrderHistoryState: ApiState.initial,
      orderHistory: null,
    );
  }

  @override
  List<Object?> get props {
    return [orderHistoryList, start, end, getOrderHistoryState, orderHistory];
  }

  OrderHistoryState copyWith({
    List<OrderHistoryData>? orderHistoryList,
    DateTime? start,
    DateTime? end,
    ApiState? getOrderHistoryState,
    OrderHistoryData? orderHistory,
  }) {
    return OrderHistoryState(
      orderHistoryList: orderHistoryList ?? this.orderHistoryList,
      start: start ?? this.start,
      end: end ?? this.end,
      getOrderHistoryState: getOrderHistoryState ?? this.getOrderHistoryState,
      orderHistory: orderHistory ?? this.orderHistory,
    );
  }
}
