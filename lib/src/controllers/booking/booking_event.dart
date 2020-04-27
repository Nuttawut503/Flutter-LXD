import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class LoadingStarted extends BookingEvent {}

class TitleUpdated extends BookingEvent {
  final String title;

  const TitleUpdated({@required this.title});

  @override
  List<Object> get props => [title];
}

class DetailUpdated extends BookingEvent {
  final String detail;

  const DetailUpdated({@required this.detail});

  @override
  List<Object> get props => [detail];
}

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

class RoomDateUpdated extends BookingEvent {
  final int roomId;
  final DateTime selectedDate;

  const RoomDateUpdated({this.roomId, this.selectedDate});

  @override
  List<Object> get props => [roomId, selectedDate];
}

class TimeIntervalUpdated extends BookingEvent {
  final DateTime startTime, endTime;

  const TimeIntervalUpdated({this.startTime, this.endTime});

  @override
  List<Object> get props => [startTime, endTime];
}

class SubmitButtonPressed extends BookingEvent {}
