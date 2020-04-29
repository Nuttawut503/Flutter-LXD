import 'package:meta/meta.dart';

@immutable
class EventState {
  final bool isLoading;
  final List<Map> roomList;
  final List<Map> eventList;
  final String textFilter;
  final bool hasCondition;
  final int selectedRoomId;

  EventState({
    @required this.isLoading,
    @required this.roomList,
    @required this.eventList,
    @required this.textFilter,
    @required this.hasCondition,
    @required this.selectedRoomId,
  });

  factory EventState.empty() {
    return EventState(
      isLoading: true,
      roomList: [],
      eventList: [],
      textFilter: '',
      hasCondition: false,
      selectedRoomId: null,
    );
  }

  EventState generatedData({
    @required List<Map> roomList,
    @required List<Map> eventList
  }) {
    return _copyWith(
      roomList: roomList,
      eventList: eventList,
      isLoading: false
    );
  }

  EventState updateTextFilter(text) {
    return _copyWith(
      textFilter: text
    );
  }

  EventState _copyWith({
    bool isLoading,
    List<Map> roomList,
    List<Map> eventList,
    String textFilter,
    bool hasCondition,
    int selectedRoomId,
  }) {
    return EventState(
      isLoading: isLoading ?? this.isLoading,
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
      isLoading: $isLoading,
      roomList: ${roomList.length},
      eventList: ${eventList.length},
      hasCondition: $hasCondition,
      selectedRoomId: $selectedRoomId,
    }''';
  }
}
