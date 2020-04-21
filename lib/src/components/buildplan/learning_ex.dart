import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LXD/src/components/buildplan/buildplan.dart';
import 'package:google_fonts/google_fonts.dart';

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
          alignment: Alignment.topLeft,
          child: _RoomSheet(),
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
  final ScrollController _scrollCtrl = ScrollController();
  final double _rightMargin = 30.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment(0, 0),
      child: ListView(
        controller: _scrollCtrl,
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(right: _rightMargin),
            child: GestureDetector(
              onTapUp: (TapUpDetails details) {
                final RenderBox box = context.findRenderObject();
                final Offset localOffset = box.globalToLocal(details.globalPosition);
                final Offset percentOffset = Offset(
                  (localOffset.dx + _scrollCtrl.position.pixels) / (500.0 - _rightMargin) * 100,
                  localOffset.dy / box.size.height * 100
                );
                BlocProvider.of<BuildplanBloc>(context).add(BuildingPlanTouched(offset: percentOffset));
              },
              child: Container(
                height: 320.0,
                width: 500.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/LX_FirstFloorPlan.png'), fit: BoxFit.fitHeight, alignment: Alignment.center)
                ),
                child: BlocBuilder<BuildplanBloc, BuildplanState>(
                  builder: (context, state) => CustomPaint(
                    painter: HightlightPainter(roomName: state.roomName, locationPoints: state.points),
                    child: Container()
                  ),
                ),
              ),
            )
          )
        ],
      )
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

class _RoomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildplanBloc, BuildplanState>(
      builder: (context, state) {
        if (state.roomName != null) {
          return Container(
            margin: EdgeInsets.only(top: 16.0, left: 16.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 10.0,
                  spreadRadius: 0.5,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(color: Colors.black),
                ),
                SizedBox(width: 16.0,),
                Container(
                  width: 170.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.roomName}',
                        style: GoogleFonts.openSans(fontSize: 18.0,),
                      ),
                      Text(
                        'Detail: ${state.roomDetail}',
                        style: GoogleFonts.openSans(fontSize: 12.0,),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Text('');
      },
    );
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
              color: Color.fromRGBO(224, 236, 248, 1.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${state.eventDetail['title']}',
                  style: GoogleFonts.openSans(fontSize: 15.0,),
                ),
                Text(
                  'Time: ${state.eventDetail['start_time']} - ${state.eventDetail['end_time']}',
                  style: GoogleFonts.openSans(fontSize: 12.0,),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: Text(
                        'see detail',
                        style: GoogleFonts.openSans(fontSize: 12.0,),
                      ),
                    )
                  ],
                )
              ],
            )
          );
        }
        return Text('');
      },
    );
  }
}
