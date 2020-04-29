import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadingStarted extends EventEvent {}

class DetailUpdated extends EventEvent {
  final String detail;

  const DetailUpdated({@required this.detail});

  @override
  List<Object> get props => [detail];
}
