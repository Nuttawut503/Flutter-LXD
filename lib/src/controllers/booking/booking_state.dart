import 'package:meta/meta.dart';

@immutable
class BookingState {
  final List<Map> roomList;
  final List<String> tags;
  final String roomId;
  final DateTime selectedDate;
  final DateTime startTime;
  final DateTime endTime;
  final bool isLoading;
  final bool isTimeCorrect;
  final bool isCheckingOverlap;
  final bool isRoomTimeValid;
  final bool isSubmitting;
  final bool isSuccess;

  BookingState({
    @required this.roomList,
    @required this.tags,
    @required this.roomId,
    @required this.selectedDate,
    @required this.startTime,
    @required this.endTime,
    @required this.isLoading,
    @required this.isTimeCorrect,
    @required this.isCheckingOverlap,
    @required this.isRoomTimeValid,
    @required this.isSubmitting,
    @required this.isSuccess,
  });

  factory BookingState.empty() {
    return BookingState(
      roomList: [],
      tags: [],
      roomId: null,
      selectedDate: null,
      startTime: null,
      endTime: null,
      isLoading: true,
      isTimeCorrect: false,
      isCheckingOverlap: false,
      isRoomTimeValid: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }

  BookingState generateRoom(roomList) {
    return _copyWith(
      roomList: roomList,
      isLoading: false
    );
  }

  BookingState addTag(tagName) {
    return _copyWith(
      tags: this.tags..add(tagName)
    );
  }

  BookingState removeTag(index) {
    return _copyWith(
      tags: this.tags..removeAt(index)
    );
  }

  BookingState _copyWith({
    List<Map> roomList,
    List<String> tags,
    String roomId,
    DateTime selectedDate,
    DateTime startTime,
    DateTime endTime,
    bool isLoading,
    bool isTimeCorrect,
    bool isCheckingOverlap,
    bool isRoomTimeValid,
    bool isSubmitting,
    bool isSuccess,
  }) {
    return BookingState(
      roomList: roomList ?? this.roomList,
      tags: tags ?? this.tags,
      roomId: roomId ?? this.roomId,
      selectedDate: selectedDate ?? this.selectedDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isLoading: isLoading ?? this.isLoading,
      isTimeCorrect: isTimeCorrect ?? this.isTimeCorrect,
      isCheckingOverlap: isCheckingOverlap ?? this.isCheckingOverlap,
      isRoomTimeValid: isRoomTimeValid ?? this.isRoomTimeValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  String toString() {
    return '''BookingState {
      roomList: ${roomList.length},
      tags: $tags,
      roomId: $roomId,
      selectedDate: $selectedDate,
      startTime: $startTime,
      endTime: $endTime,
      isLoading: $isLoading,
      isTimeCorrect: $isTimeCorrect,
      isCheckingOverlap: $isCheckingOverlap,
      isRoomTimeValid: $isRoomTimeValid,
      isSubmitting: $isSubmitting
      isSuccess: $isSuccess,
    }''';
  }
}
