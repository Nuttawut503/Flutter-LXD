import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class LoadingStarted extends BookingEvent {}

class TagAdded extends BookingEvent {
  final String tagName;

  const TagAdded({@required this.tagName});

  @override
  List<Object> get props => [tagName];
}

class TagRemoved extends BookingEvent {
  final int index;

  const TagRemoved({@required this.index});

  @override
  List<Object> get props => [index];
}
