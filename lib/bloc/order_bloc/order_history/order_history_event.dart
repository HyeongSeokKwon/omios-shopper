part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class InitOrderHistoryEvent extends OrderHistoryEvent {}

class GetOrderHistoryByIdEvent extends OrderHistoryEvent {
  final int orderId;

  const GetOrderHistoryByIdEvent({required this.orderId});
}

class GetOrderHistoryByDateEvent extends OrderHistoryEvent {}

class PagenationEvent extends OrderHistoryEvent {}

class ChangeStartTimeEvent extends OrderHistoryEvent {
  final DateTime? startTime;
  const ChangeStartTimeEvent({required this.startTime});
}

class ChangeEndTimeEvent extends OrderHistoryEvent {
  final DateTime? endTime;
  const ChangeEndTimeEvent({required this.endTime});
}
