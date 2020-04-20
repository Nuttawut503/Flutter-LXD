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
        Align(
          alignment: Alignment.center,
          child: _MapContent(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _EventSheet(),
        ),
      ],
    );
  }
}

class _MapContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        final RenderBox box = context.findRenderObject();
        final Offset localOffset = box.globalToLocal(details.globalPosition);
        final Offset percentOffset = Offset(localOffset.dx / box.size.width * 100, localOffset.dy / box.size.height * 100);
        BlocProvider.of<BuildplanBloc>(context).add(BuildingPlanTouched(offset: percentOffset));
      },
      child: Container(
        width: 250.0,
        height: 300.0,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.black,
          image: DecorationImage(image: AssetImage('assets/images/kmutt.jpg'), fit: BoxFit.cover, alignment: Alignment.center)
        ),
        child: BlocBuilder<BuildplanBloc, BuildplanState>(
          builder: (context, state) => CustomPaint(
            painter: HightlightPainter(roomName: state.roomName, locationPoints: state.points),
            child: Container()
          ),
        ),
      ),
    );
  }
}

class HightlightPainter extends CustomPainter {
  final String _roomName;
  final List<Offset> _locationPoints;
  
  HightlightPainter({Key key, @required String roomName, @required List<Offset> locationPoints})
      : _roomName = roomName,
        _locationPoints = locationPoints;

  @override
  void paint(Canvas canvas, Size size) {
    print(_roomName);
    if (_roomName == null) {
      return;
    }
    Paint paint = new Paint()
      ..color = Color.fromRGBO(197, 197, 0, 0.7)
      ..style = PaintingStyle.fill;
    Path path = new Path();
    path.moveTo(_locationPoints.last.dx / 100 * size.width, _locationPoints.last.dy / 100 * size.height);
    _locationPoints.forEach((Offset point) {
      path.lineTo(point.dx / 100 * size.width, point.dy / 100 * size.height);
    });
    canvas.drawPath(path, paint);
    paint
      ..color = Color.fromRGBO(197, 197, 197, 0.6)
      ..strokeWidth = 3.9
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HightlightPainter oldDelegate) {
    return (oldDelegate._roomName != _roomName);
  }
}

class _EventSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildplanBloc, BuildplanState>(
      builder: (context, state) {
        if (state.roomName != null) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(10.0),
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Text('${state.roomName}'),
          );
        }
        return Text('');
      },
    );
  }
}
