part of 'infinity_scroll_bloc.dart';

class InfinityScrollState extends Equatable {
  final ApiState getState;
  Map<String, dynamic> getData;
  List<dynamic> targetDatas;

  InfinityScrollState({
    required this.getState,
    required this.getData,
    required this.targetDatas,
  });

  factory InfinityScrollState.initial() {
    return InfinityScrollState(
        getState: ApiState.initial, getData: {}, targetDatas: []);
  }

  InfinityScrollState copyWith({
    ApiState? getState,
    Map<String, dynamic>? getData,
    List<dynamic>? targetDatas,
  }) {
    return InfinityScrollState(
      getState: getState ?? this.getState,
      getData: getData ?? this.getData,
      targetDatas: targetDatas ?? this.targetDatas,
    );
  }

  @override
  List<Object> get props => [getState, targetDatas, getData];
}
