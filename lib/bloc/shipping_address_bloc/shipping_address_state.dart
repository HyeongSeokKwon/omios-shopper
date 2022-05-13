part of 'shipping_address_bloc.dart';

class ShippingAddressState extends Equatable {
  final List shippingAddresses;
  final Map<String, dynamic> defaultShippingAddress;
  final Map<String, dynamic> selectedAddress;
  final ApiState getShippingAddressesState;
  final ApiState getDefaultShippingAddressState;
  final ApiState postShippingAddressState;
  final ApiState patchShippingAddressState;
  final ApiState deleteShippingAddressState;

  final String addressKinds;
  final String recipient;
  final String mobilePhoneNumber;
  final String phoneNumber;
  final String detailAddress;

  final ValidateState shippingAddressValidateState;
  final String validateErrMsg;

  final bool isDefault;
  final bool noPhoneNumber;

  const ShippingAddressState({
    required this.getShippingAddressesState,
    required this.getDefaultShippingAddressState,
    required this.selectedAddress,
    required this.postShippingAddressState,
    required this.patchShippingAddressState,
    required this.deleteShippingAddressState,
    required this.shippingAddresses,
    required this.defaultShippingAddress,
    required this.addressKinds,
    required this.recipient,
    required this.mobilePhoneNumber,
    required this.phoneNumber,
    required this.detailAddress,
    required this.isDefault,
    required this.noPhoneNumber,
    required this.shippingAddressValidateState,
    required this.validateErrMsg,
  });

  factory ShippingAddressState.initial() {
    return ShippingAddressState(
        defaultShippingAddress: {},
        shippingAddresses: [],
        selectedAddress: {},
        deleteShippingAddressState: ApiState.initial,
        getDefaultShippingAddressState: ApiState.initial,
        getShippingAddressesState: ApiState.initial,
        patchShippingAddressState: ApiState.initial,
        postShippingAddressState: ApiState.initial,
        addressKinds: '',
        detailAddress: '',
        mobilePhoneNumber: '',
        phoneNumber: '',
        recipient: '',
        isDefault: false,
        noPhoneNumber: false,
        shippingAddressValidateState: ValidateState.initial,
        validateErrMsg: '');
  }

  @override
  List<Object> get props {
    return [
      shippingAddresses,
      defaultShippingAddress,
      selectedAddress,
      getShippingAddressesState,
      getDefaultShippingAddressState,
      postShippingAddressState,
      patchShippingAddressState,
      deleteShippingAddressState,
      addressKinds,
      recipient,
      mobilePhoneNumber,
      phoneNumber,
      detailAddress,
      isDefault,
      noPhoneNumber,
      shippingAddressValidateState,
      validateErrMsg,
    ];
  }

  ShippingAddressState copyWith(
      {List? shippingAddresses,
      Map<String, dynamic>? defaultShippingAddress,
      Map<String, dynamic>? selectedAddress,
      ApiState? getShippingAddressesState,
      ApiState? getDefaultShippingAddressState,
      ApiState? postShippingAddressState,
      ApiState? patchShippingAddressState,
      ApiState? deleteShippingAddressState,
      String? addressKinds,
      String? recipient,
      String? mobilePhoneNumber,
      String? phoneNumber,
      String? detailAddress,
      bool? isDefault,
      bool? noPhoneNumber,
      ValidateState? shippingAddressValidateState,
      String? validateErrMsg}) {
    return ShippingAddressState(
      shippingAddresses: shippingAddresses ?? this.shippingAddresses,
      defaultShippingAddress:
          defaultShippingAddress ?? this.defaultShippingAddress,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      getShippingAddressesState:
          getShippingAddressesState ?? this.getShippingAddressesState,
      getDefaultShippingAddressState:
          getDefaultShippingAddressState ?? this.getDefaultShippingAddressState,
      postShippingAddressState:
          postShippingAddressState ?? this.postShippingAddressState,
      patchShippingAddressState:
          patchShippingAddressState ?? this.patchShippingAddressState,
      deleteShippingAddressState:
          deleteShippingAddressState ?? this.deleteShippingAddressState,
      addressKinds: addressKinds ?? this.addressKinds,
      recipient: recipient ?? this.recipient,
      mobilePhoneNumber: mobilePhoneNumber ?? this.mobilePhoneNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      detailAddress: detailAddress ?? this.detailAddress,
      isDefault: isDefault ?? this.isDefault,
      noPhoneNumber: noPhoneNumber ?? this.noPhoneNumber,
      shippingAddressValidateState:
          shippingAddressValidateState ?? this.shippingAddressValidateState,
      validateErrMsg: validateErrMsg ?? this.validateErrMsg,
    );
  }
}
