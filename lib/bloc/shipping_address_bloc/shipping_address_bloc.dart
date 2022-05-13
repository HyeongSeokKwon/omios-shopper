import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/addressRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'shipping_address_event.dart';
part 'shipping_address_state.dart';

class ShippingAddressBloc
    extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  final AddressRepository _addressRepository = AddressRepository();

  ShippingAddressBloc() : super(ShippingAddressState.initial()) {
    on<ShowShippingAddressesEvent>(getShippingAddresses);
    on<SetAddressEvent>(setAddessEvent);
    on<RegistShippingAddressEvent>(registShippingAddress);
    on<PatchShippingAddressEvent>(patchShippingAddress);
    on<DeleteShippingAddressEvent>(deleteShippingAddress);
    on<ClickIsDefaultEvent>(clickIsDefault);
    on<ClickNoPhoneNumberEvent>(clickNoPhoneNumber);
    on<InitPatchDataEvent>(initPatchData);
    on<InitDataEvent>(initData);
  }

  void initData(InitDataEvent event, Emitter<ShippingAddressState> emit) {
    emit(state.copyWith(
        defaultShippingAddress: {},
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
        validateErrMsg: ''));
  }

  Future<void> getShippingAddresses(ShowShippingAddressesEvent event,
      Emitter<ShippingAddressState> emit) async {
    List addressList;

    try {
      emit(state.copyWith(getShippingAddressesState: ApiState.loading));
      addressList = await _addressRepository.getAddressList();
      print(addressList);
      emit(state.copyWith(
          getShippingAddressesState: ApiState.success,
          shippingAddresses: addressList));
    } catch (e) {
      emit(state.copyWith(getShippingAddressesState: ApiState.fail));
    }
  }

  String validateData(String addressKinds, String recipient,
      String mobilePhoneNumber, String phoneNumber, String detailAddress) {
    final addressKindsRegExp = RegExp(r'^[\w\s!-~가-힣]+$');
    final recipientRegExp = RegExp(r'^[\w\s!-~가-힣]+$');
    final mobilePhoneNumberRegExp = RegExp(r'^01[0|1|6|7|8|9]\d{7,8}$');
    final phoneNumberRegExp =
        RegExp(r'^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]|70))\d{7,8}$');
    final detailAddressRegExp = RegExp(r'^[\w\s!-~가-힣]+$');

    if (!addressKindsRegExp.hasMatch(addressKinds)) {
      return '올바르지 않은 배송지 이름입니다.';
    }
    if (!recipientRegExp.hasMatch(recipient)) {
      return '수령인 이름을 확인해주세요';
    }
    if (!mobilePhoneNumberRegExp.hasMatch(mobilePhoneNumber)) {
      return '휴대폰 형식을 확인해주세요';
    }
    if (phoneNumber.isNotEmpty && !phoneNumberRegExp.hasMatch(phoneNumber)) {
      return '전화번호 형식을 확인해주세요';
    }
    if (!state.selectedAddress.isNotEmpty) {
      return '배송지를 선택해주세요';
    }
    if (!detailAddressRegExp.hasMatch(detailAddress)) {
      return '상세 주소 형식을 확인해주세요';
    }
    return '';
  }

  Future<void> registShippingAddress(RegistShippingAddressEvent event,
      Emitter<ShippingAddressState> emit) async {
    Map<String, dynamic> registData = {};
    Map<String, dynamic> postResponse = {};
    List addressList;
    emit(state.copyWith(
        shippingAddressValidateState: ValidateState.initial,
        validateErrMsg: ''));

    final validateResult = validateData(event.addressKinds, event.recipient,
        event.mobilePhoneNumber, event.phoneNumber, event.recipient);

    if (validateResult.isNotEmpty) {
      emit(state.copyWith(
          shippingAddressValidateState: ValidateState.fail,
          validateErrMsg: validateResult));
      emit(state.copyWith(shippingAddressValidateState: ValidateState.initial));
      return;
    }

    emit(state.copyWith(
      shippingAddressValidateState: ValidateState.success,
      addressKinds: event.addressKinds,
      recipient: event.recipient,
      mobilePhoneNumber: event.mobilePhoneNumber,
      phoneNumber: event.phoneNumber,
      detailAddress: event.detailAddress,
    ));

    registData['name'] = state.addressKinds;
    registData['receiver_name'] = state.recipient;
    registData['receiver_mobile_number'] = state.mobilePhoneNumber;
    registData['zip_code'] = state.selectedAddress['zonecode'];
    registData['base_address'] = state.selectedAddress['address'];
    registData['detail_address'] = state.detailAddress;
    registData['is_default'] = state.isDefault;

    try {
      emit(state.copyWith(postShippingAddressState: ApiState.loading));
      postResponse = await _addressRepository.postAddress(registData);
      addressList = await _addressRepository.getAddressList();
      emit(state.copyWith(
          postShippingAddressState: ApiState.success,
          shippingAddresses: addressList));
    } catch (e) {
      emit(state.copyWith(postShippingAddressState: ApiState.fail));
      return;
    }
  }

  Future<void> patchShippingAddress(PatchShippingAddressEvent event,
      Emitter<ShippingAddressState> emit) async {
    Map<String, dynamic> updateData = {};
    Map<String, dynamic> patchResponse = {};
    List addressList;

    emit(state.copyWith(
        shippingAddressValidateState: ValidateState.initial,
        validateErrMsg: ''));

    final validateResult = validateData(event.addressKinds, event.recipient,
        event.mobilePhoneNumber, event.phoneNumber, event.recipient);

    if (validateResult.isNotEmpty) {
      emit(state.copyWith(
          shippingAddressValidateState: ValidateState.fail,
          validateErrMsg: validateResult));
      emit(state.copyWith(shippingAddressValidateState: ValidateState.initial));
      return;
    }

    emit(state.copyWith(
      shippingAddressValidateState: ValidateState.success,
      addressKinds: event.addressKinds,
      recipient: event.recipient,
      mobilePhoneNumber: event.mobilePhoneNumber,
      phoneNumber: event.phoneNumber,
      detailAddress: event.detailAddress,
    ));

    updateData['name'] = state.addressKinds;
    updateData['receiver_name'] = state.recipient;
    updateData['receiver_mobile_number'] = state.mobilePhoneNumber;
    updateData['zip_code'] = state.selectedAddress['zonecode'];
    updateData['base_address'] = state.selectedAddress['address'];
    updateData['detail_address'] = state.detailAddress;
    updateData['is_default'] = state.isDefault;

    for (String key in state.shippingAddresses[event.index].keys.toList()) {
      if (state.shippingAddresses[event.index][key] == updateData[key]) {
        updateData.remove(key);
      }
    }
    print("update data");
    print(updateData);

    try {
      emit(state.copyWith(postShippingAddressState: ApiState.loading));
      patchResponse = await _addressRepository.patchAddress(
          state.shippingAddresses[event.index]['id'], updateData);
      addressList = await _addressRepository.getAddressList();
      emit(state.copyWith(
          postShippingAddressState: ApiState.success,
          shippingAddresses: addressList));
    } catch (e) {
      emit(state.copyWith(postShippingAddressState: ApiState.fail));
      return;
    }
  }

  Future<void> deleteShippingAddress(DeleteShippingAddressEvent event,
      Emitter<ShippingAddressState> emit) async {
    Map deleteResponse;
    List addressList;
    try {
      emit(state.copyWith(deleteShippingAddressState: ApiState.loading));
      deleteResponse = await _addressRepository
          .deleteAddress(state.shippingAddresses[event.index]['id']);
      addressList = await _addressRepository.getAddressList();
      emit(state.copyWith(
          deleteShippingAddressState: ApiState.success,
          shippingAddresses: addressList));
    } catch (e) {
      emit(state.copyWith(deleteShippingAddressState: ApiState.fail));
    }
  }

  void initPatchData(
      InitPatchDataEvent event, Emitter<ShippingAddressState> emit) {
    emit(state.copyWith(
        addressKinds: state.shippingAddresses[event.index]['name'],
        recipient: state.shippingAddresses[event.index]['receiver_name'],
        mobilePhoneNumber: state.shippingAddresses[event.index]
            ['receiver_mobile_number'],
        phoneNumber: state.shippingAddresses[event.index]
            ['receiver_phone_number'],
        detailAddress: state.shippingAddresses[event.index]['detail_address'],
        isDefault: state.shippingAddresses[event.index]['is_default'],
        noPhoneNumber: state.shippingAddresses[event.index]
                    ['receiver_phone_number'] ==
                null
            ? true
            : false,
        selectedAddress: {
          'zonecode': state.shippingAddresses[event.index]['zip_code'],
          'address': state.shippingAddresses[event.index]['base_address']
        }));
  }

  void setAddessEvent(
      SetAddressEvent event, Emitter<ShippingAddressState> emit) {
    emit(state.copyWith(selectedAddress: event.addressInfo));
  }

  void clickIsDefault(
      ClickIsDefaultEvent event, Emitter<ShippingAddressState> emit) {
    emit(state.copyWith(isDefault: event.isDefault));
  }

  void clickNoPhoneNumber(
      ClickNoPhoneNumberEvent event, Emitter<ShippingAddressState> emit) {
    emit(state.copyWith(noPhoneNumber: event.value));
  }
}
