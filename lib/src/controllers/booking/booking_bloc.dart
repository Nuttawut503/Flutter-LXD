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
    } else if (event is TagAdded) {
      yield* _mapTagAddedToState(event.tagName);
    } else if (event is TagRemoved) {
      yield* _mapTagRemovedToState(event.index);
    }
  }

  Stream<BookingState> _mapLoadingStartedToState() async* {
    yield state.generateRoom(await _roomRepository.getAllRoomList());
  }

  Stream<BookingState> _mapTagAddedToState(tagName) async* {
    yield state.addTag(tagName);
  }

  Stream<BookingState> _mapTagRemovedToState(index) async* {
    yield state.removeTag(index);
  }
}
