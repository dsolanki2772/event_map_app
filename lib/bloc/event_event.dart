import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class FetchEvents extends EventEvent {}

class ToggleFilter extends EventEvent {
  final bool showUpcoming;

  const ToggleFilter(this.showUpcoming);

  @override
  List<Object> get props => [showUpcoming];
}
