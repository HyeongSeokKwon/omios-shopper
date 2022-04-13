part of 'infinity_scroll_bloc.dart';

abstract class InfinityScrollEvent extends Equatable {
  const InfinityScrollEvent();

  @override
  List<Object> get props => [];
}

class AddDataEvent extends InfinityScrollEvent {}

class ResetDataEvent extends InfinityScrollEvent {
  final Map<String, dynamic> getData;
  ResetDataEvent({
    required this.getData,
  });
}
