import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LXD/src/components/buildplan/buildplan.dart';

class LearningExchange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuildplanBloc>(
      create: (context) => BuildplanBloc(),
      child: _MapBackground(),
    );
  }
}

class _MapBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTapUp: (TapUpDetails details) {
            BlocProvider.of<BuildplanBloc>(context).add(BuildingPlanDismissed());
          },
          child: Container(decoration: BoxDecoration(),),
        ),
        _MapContent(),
        _EventSheet(),
      ],
    );
  }
}

class _MapContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class _EventSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}