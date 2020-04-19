import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class BuildplanEvent extends Equatable {
  const BuildplanEvent();

  @override
  List<Object> get props => [];
}

class BuildingPlanTouched extends BuildplanEvent {
  final Offset offset;

  const BuildingPlanTouched({@required this.offset});
}

class BuildingPlanDismissed extends BuildplanEvent {}
