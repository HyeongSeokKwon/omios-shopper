part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  final List<OrderHistoryData> orderHistoryList;
  final List orderStatistics;
  final DateTime? start;
  final DateTime? end;
  final ApiState getOrderHistoryState;
  final OrderHistoryData? orderHistory;
  final Map orderDetailPriceInfo;

  OrderHistoryState(
      {required this.orderHistoryList,
      required this.orderStatistics,
      this.start,
      this.end,
      required this.getOrderHistoryState,
      required this.orderHistory,
      required this.orderDetailPriceInfo});

  factory OrderHistoryState.initial() {
    return OrderHistoryState(
      orderHistoryList: [],
      orderStatistics: [],
      start: DateTime(0),
      end: DateTime(0),
      getOrderHistoryState: ApiState.initial,
      orderHistory: null,
      orderDetailPriceInfo: {},
    );
  }

  @override
  List<Object?> get props {
    return [
      orderHistoryList,
      orderStatistics,
      start,
      end,
      getOrderHistoryState,
      orderHistory,
      orderDetailPriceInfo,
    ];
  }

  OrderHistoryState copyWith({
    List<OrderHistoryData>? orderHistoryList,
    List? orderStatistics,
    DateTime? start,
    DateTime? end,
    ApiState? getOrderHistoryState,
    OrderHistoryData? orderHistory,
    Map? orderDetailPriceInfo,
  }) {
    return OrderHistoryState(
      orderHistoryList: orderHistoryList ?? this.orderHistoryList,
      orderStatistics: orderStatistics ?? this.orderStatistics,
      start: start ?? this.start,
      end: end ?? this.end,
      getOrderHistoryState: getOrderHistoryState ?? this.getOrderHistoryState,
      orderHistory: orderHistory ?? this.orderHistory,
      orderDetailPriceInfo: orderDetailPriceInfo ?? this.orderDetailPriceInfo,
    );
  }
}
