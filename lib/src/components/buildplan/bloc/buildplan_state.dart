import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class BuildplanState {
  final String roomName;
  final List<Offset> points;
  final Map<String, String> eventDetail;

  BuildplanState({
    @required this.roomName,
    @required this.points,
    @required this.eventDetail,
  });

  factory BuildplanState.dismiss() => BuildplanState(
    roomName: null,
    points: null,
    eventDetail: null,
  );

  factory BuildplanState.roomDetail({
    String roomName,
    List<Offset> points,
    Map<String, String> eventDetail,
  }) => BuildplanState(
    roomName: roomName,
    points: points,
    eventDetail: eventDetail,
  );
}