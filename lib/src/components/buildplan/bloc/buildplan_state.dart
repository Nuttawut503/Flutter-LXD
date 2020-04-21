import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class BuildplanState {
  final String roomName;
  final String roomDetail;
  final List<Offset> points;
  final Map<String, String> eventDetail;

  BuildplanState({
    @required this.roomName,
    @required this.roomDetail,
    @required this.points,
    @required this.eventDetail,
  });

  factory BuildplanState.dismiss() => BuildplanState(
    roomName: null,
    roomDetail: null,
    points: null,
    eventDetail: null,
  );

  factory BuildplanState.roomEventDetail({
    String roomName,
    String roomDetail,
    List<Offset> points,
    Map<String, String> eventDetail,
  }) => BuildplanState(
    roomName: roomName,
    roomDetail: roomDetail,
    points: points,
    eventDetail: eventDetail,
  );
}
