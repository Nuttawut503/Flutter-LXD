import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadingStarted extends EventEvent {}

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
