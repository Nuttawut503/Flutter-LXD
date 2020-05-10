import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:LXD/src/api/event_repository.dart';
import 'package:LXD/src/api/room_repository.dart';
import 'package:LXD/src/controllers/event/bloc.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventRepository _eventRepository = EventRepository();
  RoomRepository _roomRepository = RoomRepository();
  StreamSubscription _eventSubscription;

  @override
  EventState get initialState => UnloadedEvent();
  
  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is LoadingStarted) {
      yield* _mapLoadingStartedToState();
    } else if (event is EventUpdated) {
      yield* _mapEventUpdatedToState(event.eventList);
    } else if (event is TextFilterUpdated) {
      yield* _mapTextFilterUpdatedToState(event.text);
    } else if (event is MarkerDismissed) {
      yield* _mapMarkerDismissedToState();
    } else if (event is MarkerTouched) {
      yield* _mapMarkerTouchedToState(event.index);
    }
  }

  Stream<EventState> _mapLoadingStartedToState() async* {
    yield LoadedEvent(
      roomList: await _roomRepository.getAllRoomList(),
      eventList: [],
      textFilter: '',
      hasCondition: false,
      selectedRoomId: null,
    );
    _eventSubscription?.cancel();
    _eventSubscription = _eventRepository.getAllEventList().listen(
                        (eventList) => add(
                          EventUpdated(
                            eventList: eventList..sort((a, b) {
                              DateTime s1 = a['stime'], e1 = a['etime'];
                              DateTime s2 = b['stime'], e2 = b['etime'];
                              int fCompare = s1.compareTo(s2);
                              return (fCompare == 0)? e1.compareTo(e2): fCompare;
                            })
                          )
                        ));
  }

  Stream<EventState> _mapEventUpdatedToState(eventList) async* {
    yield (state as LoadedEvent).updateEventList(eventList);
  }

  Stream<EventState> _mapTextFilterUpdatedToState(text) async* {
    yield (state as LoadedEvent).updateTextFilter(text);
  }

  Stream<EventState> _mapMarkerDismissedToState() async* {
    yield (state as LoadedEvent).dismissRoomId();
  }

  Stream<EventState> _mapMarkerTouchedToState(index) async* {
    yield (state as LoadedEvent).touchRoomId(index);
  }

  @override
  Future<void> close() {
    _eventSubscription.cancel();
    return super.close();
  }
}
