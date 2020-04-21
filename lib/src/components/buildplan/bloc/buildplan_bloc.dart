import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:LXD/src/components/buildplan/buildplan.dart';
import 'package:LXD/src/components/buildplan/bloc/ray_casting.dart';
import 'package:intl/intl.dart';

class BuildplanBloc extends Bloc<BuildplanEvent, BuildplanState> {
  @override
  BuildplanState get initialState => BuildplanState.dismiss();

  @override
  Stream<BuildplanState> mapEventToState(BuildplanEvent event) async* {
    if (event is BuildingPlanDismissed) {
      yield* _mapBuildingPlanDismissedToState();
    } else if (event is BuildingPlanTouched) {
      yield* _mapBuildingPlanTouchedToState(event.offset);
    }
  }

  Stream<BuildplanState> _mapBuildingPlanDismissedToState() async* {
    yield BuildplanState.dismiss();
  }

  Stream<BuildplanState> _mapBuildingPlanTouchedToState(Offset offset) async* {
    String roomName = Building.getRoomName(offset);
    yield BuildplanState.roomEventDetail(
      roomName: roomName,
      roomDetail: 'ugwemubwem ossas',
      points: (roomName == null)?[]: Building.rooms['$roomName'],
      eventDetail: (roomName == null)?{}: {
        'reserver_id': 'AIzaS2wXlOKxP2',
        'title': 'XXXXXX',
        'detail': 'asdvxcvwdfsazcxcsfqasd',
        'date': DateFormat.yMMMMd('en_US').format(DateTime.now()),
        'start_time': DateFormat.Hm().format(DateTime.now()),
        'end_time': DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + (1 << 20))),
      }
    );
  }
}
