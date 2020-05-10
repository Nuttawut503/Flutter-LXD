import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadingStarted extends EventEvent {}

class EventUpdated extends EventEvent {
  final List<Map> eventList;

  const EventUpdated({@required this.eventList});

  @override
  List<Object> get props => [eventList];
}

class TextFilterUpdated extends EventEvent {
  final String text;

  const TextFilterUpdated({@required this.text});

  @override
  List<Object> get props => [text];
}

class MarkerDismissed extends EventEvent {}

class MarkerTouched extends EventEvent {
  final int index;

  const MarkerTouched({@required this.index});

  @override
  List<Object> get props => [index];
}
