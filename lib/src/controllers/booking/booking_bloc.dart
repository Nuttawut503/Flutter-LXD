import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:LXD/src/controllers/booking/bloc.dart';
import 'package:LXD/src/api/room_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final String _userId;
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
    roomId = (roomId == null)? state.roomId: int.parse(roomId.toString());
    yield state.updateRoomDate(roomId: roomId, selectedDate: selectedDate);
    if (state.updateRoomDate(roomId: roomId, selectedDate: selectedDate).isTimeCompleted()) {
      yield state.updateStatus(isCheckingOverlap: true);
      bool isOverlapped = await _roomRepository.isTimeOverlapped(
        roomId: roomId ?? state.roomId,
        selectedDate: selectedDate ?? state.selectedDate,
        startTime: state.startTime,
        endTime: state.endTime,
      );
      if (isOverlapped) {
        yield state.updateStatus(isCheckingOverlap: false, isRoomTimeValid: false);
      } else {
        yield state.updateStatus(isCheckingOverlap: false, isRoomTimeValid: true);
      }
    }
  }

  Stream<BookingState> _mapTimeIntervalUpdatedToState({DateTime startTime, DateTime endTime}) async* {
    yield state.updateTimeInterval(startTime: startTime, endTime: endTime);
    if (!startTime.isBefore(endTime)) {
      yield state.updateStatus(isTimeCorrect: false);
    } else {
      yield state.updateStatus(isTimeCorrect: true);
    }
    if (state.updateTimeInterval(startTime: startTime, endTime: endTime).isTimeCompleted()) {
      yield state.updateStatus(isCheckingOverlap: true);
      bool isOverlapped = await _roomRepository.isTimeOverlapped(
        roomId: state.roomId,
        selectedDate: state.selectedDate,
        startTime: startTime ?? state.startTime,
        endTime: endTime ?? state.endTime,
      );
      if (isOverlapped) {
        yield state.updateStatus(isCheckingOverlap: false, isRoomTimeValid: false);
      } else {
        yield state.updateStatus(isCheckingOverlap: false, isRoomTimeValid: true);
      }
    }
  }

  Stream<BookingState> _mapSubmitButtonPressedToState() async* {
    yield state.updateStatus(isSubmitting: true);
    bool isOverlapped = await _roomRepository.isTimeOverlapped(
        roomId: state.roomId,
        selectedDate: state.selectedDate,
        startTime: state.startTime,
        endTime: state.endTime,
    );
    if (isOverlapped) {
      yield state.updateStatus(isRoomTimeValid: false, isSubmitting: false);
    } else {
      await _roomRepository.addEvent(
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
