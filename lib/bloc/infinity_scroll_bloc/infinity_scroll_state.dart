part of 'infinity_scroll_bloc.dart';

class InfinityScrollState extends Equatable {
  final FetchState getState;
  Map<String, dynamic> getData;
  List<dynamic> productData;

  InfinityScrollState({
    required this.getState,
    required this.getData,
    required this.productData,
  });

  factory InfinityScrollState.initial() {
    return InfinityScrollState(
        getState: FetchState.initial, getData: {}, productData: []);
  }

  InfinityScrollState copyWith({
    FetchState? getState,
    Map<String, dynamic>? getData,
    List<dynamic>? productData,
  }) {
    return InfinityScrollState(
      getState: getState ?? this.getState,
      getData: getData ?? this.getData,
      productData: productData ?? this.productData,
    );
  }

  @override
  List<Object> get props => [getState, productData, getData];
}
