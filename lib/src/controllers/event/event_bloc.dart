import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:LXD/src/controllers/event/bloc.dart';
import 'package:LXD/src/api/event_repository.dart';
import 'package:LXD/src/api/room_repository.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventRepository _eventRepository = EventRepository();
  RoomRepository _roomRepository = RoomRepository();

  @override
  EventState get initialState => EventState.empty();
  
  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is LoadingStarted) {
      yield* _mapLoadingStartedToState();
    }
  }

  Stream<EventState> _mapLoadingStartedToState() async* {
    yield state.generatedData(
      roomList: await _roomRepository.getAllRoomList(),
      eventList: await _eventRepository.getAllEventList(),
    );
  }
}
