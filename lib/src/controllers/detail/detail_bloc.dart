import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:LXD/src/controllers/detail/bloc.dart';
import 'package:LXD/src/api/user_repository.dart';
import 'package:LXD/src/api/event_repository.dart';
import 'package:LXD/src/api/room_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  EventRepository _eventRepository = EventRepository();
  UserRepository _userRepository = UserRepository();
  RoomRepository _roomRepository = RoomRepository();
  String _eventId;

  DetailBloc({
    @required String eventId,
  })  : assert(eventId != null),
        _eventId = eventId;

  @override
  DetailState get initialState => DetailState.empty();
  
  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is LoadingStarted) {
      yield* _mapLoadingStartedToState();
    }
  }

  Stream<DetailState> _mapLoadingStartedToState() async* {
    try {
      Map eventDetail = await _eventRepository.getEventDetailById(_eventId);
      eventDetail['reserver_name'] = await _userRepository.findNameOfUserById(eventDetail['reserver_id']);
      eventDetail['room'] = await _roomRepository.getRoomNameById(int.parse(eventDetail['room_id']));
      yield DetailState.update(eventDetail);
    } catch (_) {
      yield DetailState.failure();
    }
  }
}
