import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:LXD/src/controllers/booking/bloc.dart';
import 'package:LXD/src/api/event_repository.dart';
import 'package:LXD/src/api/room_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final String _userId;
  EventRepository _eventRepository = EventRepository();
  RoomRepository _roomRepository = RoomRepository();

  BookingBloc({@required String userId})
      : _userId = userId;

  @override
  BookingState get initialState => BookingState.empty();
  
  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is LoadingStarted) {
      yield* _mapLoadingStartedToState();
    } else if (event is TitleUpdated) {
      yield* _mapTitleUpdatedToState(event.title);
    } else if (event is DetailUpdated) {
      yield* _mapDetailUpdatedToState(event.detail);
    } else if (event is TagAdded) {
      yield* _mapTagAddedToState(event.tagName);
    } else if (event is TagRemoved) {
      yield* _mapTagRemovedToState(event.index);
    } else if (event is RoomDateUpdated) {
      yield* _mapRoomDateUpdatedToState(roomId: event.roomId, selectedDate: event.selectedDate);
    } else if (event is TimeIntervalUpdated) {
      yield* _mapTimeIntervalUpdatedToState(startTime: event.startTime, endTime: event.endTime);
    } else if (event is SubmitButtonPressed) {
      yield* _mapSubmitButtonPressedToState();
    }
  }

  Stream<BookingState> _mapLoadingStartedToState() async* {
    yield state.generateRoom(await _roomRepository.getAllRoomList());
  }

  Stream<BookingState> _mapTitleUpdatedToState(title) async* {
    yield state.updateDescription(title: title.toString().trim().replaceAll(RegExp(' +'), ' '));
  }

  Stream<BookingState> _mapDetailUpdatedToState(detail) async* {
    yield state.updateDescription(detail: detail.toString().trim().replaceAll(RegExp(' +'), ' '));
  }

  Stream<BookingState> _mapTagAddedToState(tagName) async* {
    yield state.addTag(tagName);
  }

  Stream<BookingState> _mapTagRemovedToState(index) async* {
    yield state.removeTag(index);
  }

  Stream<BookingState> _mapRoomDateUpdatedToState({int roomId, DateTime selectedDate}) async* {
    roomId = roomId ?? state.roomId;
    if (selectedDate == null) {
      yield state.resetRoomDate(roomId);
    } else {
      yield state.updateRoomDate(roomId: roomId, selectedDate: selectedDate);
      if (state.updateRoomDate(roomId: roomId, selectedDate: selectedDate).isTimeCompleted()) {
        yield state.updateStatus(isCheckingOverlap: true);
        bool isOverlapped = await _roomRepository.isRoomTimeOverlapped(
          roomId: roomId ?? state.roomId,
          selectedDate: selectedDate ?? state.selectedDate,
          startTime: state.startTime,
          endTime: state.endTime,
        );
        if (isOverlapped) {
          yield state.updateRoomDate(roomId: roomId, selectedDate: selectedDate).updateStatus(isCheckingOverlap: false, isRoomTimeValid: false);
        } else {
          yield state.updateRoomDate(roomId: roomId, selectedDate: selectedDate).updateStatus(isCheckingOverlap: false, isRoomTimeValid: true);
        }
      }
    }
  }

  Stream<BookingState> _mapTimeIntervalUpdatedToState({DateTime startTime, DateTime endTime}) async* {
    startTime = startTime ?? state.startTime;
    endTime = endTime ?? state.endTime;
    print(endTime);
    yield state.updateTimeInterval(startTime: startTime, endTime: endTime);
    if (startTime != null && endTime != null) {
      if (!startTime.isBefore(endTime)) {
        yield state.updateTimeInterval(startTime: startTime, endTime: endTime).updateStatus(isTimeCorrect: false);
      } else {
        yield state.updateTimeInterval(startTime: startTime, endTime: endTime).updateStatus(isTimeCorrect: true);
        if (state.updateTimeInterval(startTime: startTime, endTime: endTime).isTimeCompleted()) {
          yield state.updateTimeInterval(startTime: startTime, endTime: endTime).updateStatus(isTimeCorrect: true, isCheckingOverlap: true);
          bool isOverlapped = await _roomRepository.isRoomTimeOverlapped(
            roomId: state.roomId,
            selectedDate: state.selectedDate,
            startTime: startTime,
            endTime: endTime,
          );
          if (isOverlapped) {
            yield state.updateTimeInterval(startTime: startTime, endTime: endTime).updateStatus(isTimeCorrect: true, isCheckingOverlap: false, isRoomTimeValid: false);
          } else {
            yield state.updateTimeInterval(startTime: startTime, endTime: endTime).updateStatus(isTimeCorrect: true, isCheckingOverlap: false, isRoomTimeValid: true);
          }
        }
      }
    }
  }

  Stream<BookingState> _mapSubmitButtonPressedToState() async* {
    yield state.updateStatus(isSubmitting: true);
    bool isOverlapped = await _roomRepository.isRoomTimeOverlapped(
        roomId: state.roomId,
        selectedDate: state.selectedDate,
        startTime: state.startTime,
        endTime: state.endTime,
    );
    if (isOverlapped) {
      yield state.updateStatus(isRoomTimeValid: false, isSubmitting: false);
    } else {
      await _eventRepository.addEvent(
        reserverId: '$_userId',
        title: state.title,
        detail: state.detail,
        tags: state.tags,
        roomId: state.roomId.toString(),
        selectedDate: state.selectedDate,
        startTime: state.startTime,
        endTime: state.endTime,
      );
      yield state.updateStatus(isSubmitting: false, isSuccess: true);
    }
  }
}
