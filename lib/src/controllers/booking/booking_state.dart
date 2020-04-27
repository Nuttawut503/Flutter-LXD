import 'package:meta/meta.dart';

@immutable
class BookingState {
  final List<Map> roomList;
  final String title;
  final String detail;
  final List<String> tags;
  final int roomId;
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
    @required this.title,
    @required this.detail,
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
      title: '',
      detail: '',
      tags: [],
      roomId: 0,
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

  BookingState updateDescription({
    title,
    detail,
  }) {
    return _copyWith(
      title: title,
      detail: detail,
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

  BookingState updateRoomDate({
    roomId,
    selectedDate
  }) {
    return _copyWith(
      roomId: roomId,
      selectedDate: selectedDate
    );
  }

  BookingState updateTimeInterval({
    startTime,
    endTime,
  }) {
    return _copyWith(
      startTime: startTime,
      endTime: endTime,
    );
  }

  BookingState updateStatus({
    bool isTimeCorrect,
    bool isCheckingOverlap,
    bool isRoomTimeValid,
    bool isSubmitting,
    bool isSuccess,
  }) {
    return _copyWith(
      isTimeCorrect: isTimeCorrect,
      isCheckingOverlap: isCheckingOverlap,
      isRoomTimeValid: isRoomTimeValid,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
    );
  }

  bool isTimeCompleted() {
    return ((this.roomId != null)
            && (this.selectedDate != null)
            && (this.startTime != null)
            && (this.endTime != null));
  }

  BookingState _copyWith({
    List<Map> roomList,
    String title,
    String detail,
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
      title: title ?? this.title,
      detail: detail ?? this.detail,
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
      title: $title,
      detail: $detail,
      tags: $tags,
      roomId: $roomId,
      selectedDate: $selectedDate,
      startTime: $startTime, endTime: $endTime,
      isLoading: $isLoading,
      isTimeCorrect: $isTimeCorrect,
      isCheckingOverlap: $isCheckingOverlap,
      isRoomTimeValid: $isRoomTimeValid,
      isSubmitting: $isSubmitting, isSuccess: $isSuccess,
    }''';
  }
}
