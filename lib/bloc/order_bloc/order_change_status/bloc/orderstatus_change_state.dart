part of 'orderstatus_change_bloc.dart';

class OrderstatusChangeState extends Equatable {
  final ApiState cancelOrderState;
  final ApiState changeShippingAddressState;
  final ApiState changeOptionState;
  final ApiState getOptionInfoState;

  final List optionList;

  const OrderstatusChangeState({
    required this.cancelOrderState,
    required this.changeShippingAddressState,
    required this.changeOptionState,
    required this.getOptionInfoState,
    required this.optionList,
  });

  @override
  List<Object> get props => [
        cancelOrderState,
        changeShippingAddressState,
        changeOptionState,
        getOptionInfoState,
        optionList
      ];

  factory OrderstatusChangeState.initial() {
    return OrderstatusChangeState(
      cancelOrderState: ApiState.initial,
      changeShippingAddressState: ApiState.initial,
      changeOptionState: ApiState.initial,
      getOptionInfoState: ApiState.initial,
      optionList: [],
    );
  }

  OrderstatusChangeState copyWith({
    ApiState? cancelOrderState,
    ApiState? changeShippingAddressState,
    ApiState? changeOptionState,
    ApiState? getOptionInfoState,
    List? optionList,
  }) {
    return OrderstatusChangeState(
      cancelOrderState: cancelOrderState ?? this.cancelOrderState,
      changeShippingAddressState:
          changeShippingAddressState ?? this.changeShippingAddressState,
      changeOptionState: changeOptionState ?? this.changeOptionState,
      getOptionInfoState: getOptionInfoState ?? this.getOptionInfoState,
      optionList: optionList ?? this.optionList,
    );
  }
}
