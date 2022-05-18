part of 'shipping_address_bloc.dart';

abstract class ShippingAddressEvent extends Equatable {
  const ShippingAddressEvent();

  @override
  List<Object> get props => [];
}

class InitPatchDataEvent extends ShippingAddressEvent {
  final int index;

  const InitPatchDataEvent({required this.index});
}

class ShowShippingAddressesEvent extends ShippingAddressEvent {}

class RegistShippingAddressEvent extends ShippingAddressEvent {
  final String addressKinds;
  final String recipient;
  final String mobilePhoneNumber;
  final String phoneNumber;
  final String detailAddress;
  const RegistShippingAddressEvent({
    required this.addressKinds,
    required this.recipient,
    required this.mobilePhoneNumber,
    required this.phoneNumber,
    required this.detailAddress,
  });
}

class DeleteShippingAddressEvent extends ShippingAddressEvent {
  final int index;
  const DeleteShippingAddressEvent({required this.index});
}

class PatchShippingAddressEvent extends ShippingAddressEvent {
  final int index;
  final String addressKinds;
  final String recipient;
  final String mobilePhoneNumber;
  final String phoneNumber;
  final String detailAddress;

  const PatchShippingAddressEvent({
    required this.index,
    required this.addressKinds,
    required this.recipient,
    required this.mobilePhoneNumber,
    required this.phoneNumber,
    required this.detailAddress,
  });
}

class SetAddressEvent extends ShippingAddressEvent {
  final Map<String, dynamic> addressInfo;
  const SetAddressEvent({
    required this.addressInfo,
  });
}

class ClickNoPhoneNumberEvent extends ShippingAddressEvent {
  final bool value;
  const ClickNoPhoneNumberEvent({required this.value});
}

class ClickIsDefaultEvent extends ShippingAddressEvent {
  final bool isDefault;
  const ClickIsDefaultEvent({
    required this.isDefault,
  });
}

class InitDataEvent extends ShippingAddressEvent {}

class SetRequirementEvent extends ShippingAddressEvent {
  final String requirement;
  const SetRequirementEvent({required this.requirement});
}

class SelectAddressEvent extends ShippingAddressEvent {
  final int index;
  const SelectAddressEvent({required this.index});
}
