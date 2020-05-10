import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class UnloadedEvent extends EventState {}

@immutable
class LoadedEvent extends EventState {
  final List<Map> roomList;
  final List<Map> eventList;
  final String textFilter;
  final bool hasCondition;
  final int selectedRoomId;

  LoadedEvent({
    @required this.roomList,
    @required this.eventList,
    @required this.textFilter,
    @required this.hasCondition,
    @required this.selectedRoomId,
  });

  LoadedEvent updateEventList(eventList) {
    return _copyWith(
      eventList: eventList,
    );
  }

  LoadedEvent updateTextFilter(text) {
    return _copyWith(
      textFilter: text
    );
  }

  List<Map> filteredList() {
    return eventList.where((elem) => elem['title'].toString().toLowerCase().indexOf(textFilter.toLowerCase()) != -1 && (!hasCondition || elem['room_id'] == selectedRoomId.toString())).toList();
  }

  LoadedEvent dismissRoomId() {
    return LoadedEvent(
      roomList: this.roomList,
      eventList: this.eventList,
      textFilter: this.textFilter,
      hasCondition: false,
      selectedRoomId: null,
    );
  }

  LoadedEvent touchRoomId(index) {
    return _copyWith(
      hasCondition: true,
      selectedRoomId: index,
    );
  }

  LoadedEvent _copyWith({
    List<Map> roomList,
    List<Map> eventList,
    String textFilter,
    bool hasCondition,
    int selectedRoomId,
  }) {
    return LoadedEvent(
      roomList: roomList ?? this.roomList,
      eventList: eventList ?? this.eventList,
      textFilter: textFilter ?? this.textFilter,
      hasCondition: hasCondition ?? this.hasCondition,
      selectedRoomId: selectedRoomId ?? this.selectedRoomId,
    );
  }

  @override
  String toString() {
    return '''EventState {
      roomList: ${roomList.length},
      eventList: ${eventList.length},
      textFilter: $textFilter,
      hasCondition: $hasCondition,
      selectedRoomId: $selectedRoomId,
    }''';
  }

  @override
  List<Object> get props => [roomList, eventList, textFilter, hasCondition, selectedRoomId];
}
