part of 'shipping_address_bloc.dart';

class ShippingAddressState extends Equatable {
  final List shippingAddresses;
  final Map<String, dynamic> defaultShippingAddress;
  final Map<String, dynamic> selectedAddressInKakao; //kakao 주소찾기에서 선택된 주소
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
  final String zipCode;
  final String baseAddress;
  final String detailAddress;

  final ValidateState shippingAddressValidateState;
  final String validateErrMsg;
  final String requirement;

  final bool isDefault;
  final bool noPhoneNumber;

  const ShippingAddressState({
    required this.getShippingAddressesState,
    required this.getDefaultShippingAddressState,
    required this.selectedAddressInKakao,
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
    required this.zipCode,
    required this.baseAddress,
    required this.detailAddress,
    required this.requirement,
    required this.isDefault,
    required this.noPhoneNumber,
    required this.shippingAddressValidateState,
    required this.validateErrMsg,
  });

  factory ShippingAddressState.initial() {
    return ShippingAddressState(
        defaultShippingAddress: {},
        shippingAddresses: [],
        selectedAddressInKakao: {},
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
        baseAddress: '',
        zipCode: '',
        requirement: '',
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
      selectedAddressInKakao,
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
      zipCode,
      baseAddress,
      requirement,
      isDefault,
      noPhoneNumber,
      shippingAddressValidateState,
      validateErrMsg,
    ];
  }

  ShippingAddressState copyWith(
      {List? shippingAddresses,
      Map<String, dynamic>? defaultShippingAddress,
      Map<String, dynamic>? selectedAddressInKakao,
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
      String? zipCode,
      String? baseAddress,
      String? detailAddress,
      String? requirement,
      bool? isDefault,
      bool? noPhoneNumber,
      ValidateState? shippingAddressValidateState,
      String? validateErrMsg}) {
    return ShippingAddressState(
      shippingAddresses: shippingAddresses ?? this.shippingAddresses,
      defaultShippingAddress:
          defaultShippingAddress ?? this.defaultShippingAddress,
      selectedAddressInKakao:
          selectedAddressInKakao ?? this.selectedAddressInKakao,
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
      zipCode: zipCode ?? this.zipCode,
      baseAddress: baseAddress ?? this.baseAddress,
      requirement: requirement ?? this.requirement,
      isDefault: isDefault ?? this.isDefault,
      noPhoneNumber: noPhoneNumber ?? this.noPhoneNumber,
      shippingAddressValidateState:
          shippingAddressValidateState ?? this.shippingAddressValidateState,
      validateErrMsg: validateErrMsg ?? this.validateErrMsg,
    );
  }
}
