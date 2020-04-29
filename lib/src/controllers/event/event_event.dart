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
