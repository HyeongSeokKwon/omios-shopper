part of 'orderstatus_change_bloc.dart';

abstract class OrderstatusChangeEvent extends Equatable {
  const OrderstatusChangeEvent();

  @override
  List<Object> get props => [];
}

class CancelOrderEvent extends OrderstatusChangeEvent {
  final int orderId;
  final int itemId;
  const CancelOrderEvent({
    required this.orderId,
    required this.itemId,
  });
}

class ChangeShippingAddressEvent extends OrderstatusChangeEvent {
  final OrderHistoryData orderHistoryData;
  const ChangeShippingAddressEvent({required this.orderHistoryData});
}

class ClickChangeOptionEvent extends OrderstatusChangeEvent {
  final int productId;
  const ClickChangeOptionEvent({required this.productId});
}

class ChangeOptionEvent extends OrderstatusChangeEvent {
  final int itemId;
  final int optionId;
  const ChangeOptionEvent({required this.itemId, required this.optionId});
}
