import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/controllers/event/bloc.dart';
import 'package:LXD/src/views/event_detail_screen.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.of(context).pop();
            }
          },
          child: BlocProvider<EventBloc>(
            create: (context) => EventBloc()..add(LoadingStarted()),
            child: Column(
              children: [
                _HeaderEventView(),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: _ContentEventView(),
                  )
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class _HeaderEventView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(208, 219, 217, 1.0),
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              splashColor: Colors.black.withOpacity(0.3),
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Icon(FontAwesomeIcons.arrowLeft, size: 16.0),
              ),
            )
          ),
          Spacer(),
          Text(
            'Events',
            style: GoogleFonts.openSans(fontSize: 19.0)
          ),
          Spacer(),
          Opacity(
            opacity: 0,
            child: Material(
              child: InkWell(
                onTap: null,
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(FontAwesomeIcons.arrowLeft, size: 16.0),
                ),
              )
            )
          ),
        ]
      ),
    );
  }
}

class _ContentEventView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(208, 219, 217, 1.0),
      ),
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _EventView();
          }
        },
      )
    );
  }
}

class _EventView extends StatefulWidget {
  @override
  State<_EventView> createState() => _EventViewState();
}

class _EventViewState extends State<_EventView> with TickerProviderStateMixin {
  Timer _debounce;
  @override
  void dispose() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child:TextFormField(
                    maxLength: 30,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    autocorrect: false,
                    style: GoogleFonts.openSans(fontSize: 19.0),
                    onChanged: (text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(Duration(milliseconds: 900), () {
                        BlocProvider.of<EventBloc>(context).add(TextFilterUpdated(text: text));
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type here to find',
                      hintStyle: GoogleFonts.openSans(),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide(
                          width: 0, 
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.0,),
            Align(
              alignment: Alignment.center,
              child: _BuildingMarker(),
            ),
            SizedBox(height: 12.0,),
            Expanded(
              child: ListView(
                children: [
                  if (state.hasCondition)
                    _RoomCard(room: state.roomList[state.selectedRoomId]),
                  for (Map evt in state.filteredList())
                    _EventCard(
                      title: evt['title'],
                      date: evt['schedule']['date'],
                      room: state.roomList[int.parse(evt['room_id'])]['name'],
                      startTime: evt['schedule']['start_time'],
                      endTime: evt['schedule']['end_time'],
                      eventId: evt['event_id'],
                      tags: evt['tags']
                    )
                ],
              )
            )
          ],
        );
      },
    );
  }
}

class _BuildingMarker extends StatelessWidget {
  final double _imageWidth = 200.0, _imageHeight = 200.0;
  final _mockUpPosition = [Offset(20.0, 35.0), Offset(60.0, 20.0), Offset(47.0, 50.0)];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        return Stack(
          overflow: Overflow.visible,
          children: [
            GestureDetector(
              onTap: () {
                BlocProvider.of<EventBloc>(context).add(MarkerDismissed());
              },
              child: Container(
                width: _imageWidth,
                height: _imageWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/building_plan.png'),
                    fit: BoxFit.cover
                  )
                ),
                child: CustomPaint(
                  painter: HightlightPainter(index: state.selectedRoomId),
                  child: Container(),
                ),
              ),
            ),
            for (int i = 0; i < _mockUpPosition.length; ++i) 
              (!state.hasCondition || i != state.selectedRoomId)?Positioned(
                top: _mockUpPosition[i].dy / 100 * _imageHeight,
                left: _mockUpPosition[i].dx / 100 * _imageWidth,
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<EventBloc>(context).add(MarkerTouched(index: i));
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle)
                  ),
                )
              ):Text(''),
            
          ],
        ); 
      },
    );
  }
}

class _RoomCard extends StatelessWidget {
  final Map _room;

  _RoomCard({@required room})
      : _room = room;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 36.0,
                height: 36.0,
                fit: BoxFit.cover,
                imageUrl: '${_room['picture']}',
                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                  child: CircularProgressIndicator(value: downloadProgress.progress),
                ), 
                errorWidget: (context, url, error) => Center(
                  child: Icon(FontAwesomeIcons.exclamationTriangle),
                ),
              ),
              SizedBox(width: 16.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${_room['name']}', style: GoogleFonts.openSans()),
                  Text('${_room['detail']}', style: GoogleFonts.openSans(fontSize: 13.0))
                ],
              )
            ],
          )
        ),
      )
    );
  }
}

class _EventCard extends StatelessWidget {
  final String _title, _date, _stime, _etime, _room, _eventId;
  final List _tags;

  _EventCard({@required title, @required date, @required room, @required startTime, @required endTime, @required eventId, @required tags})
      : _title = title,
        _date = date,
        _room = room,
        _stime = startTime,
        _etime = endTime,
        _eventId = eventId,
        _tags = tags;

  @override
  Widget build(BuildContext context) {
    Widget _tagList = Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 6.0,
      children: [
        Text('tags: ', style: GoogleFonts.openSans(),),
        for (String tag in _tags)
          Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Badge(
              badgeColor: Color.fromRGBO(166, 200, 200, 1.0),
              padding: EdgeInsets.all(5.0),
              shape: BadgeShape.square,
              borderRadius: 20,
              toAnimate: false,
              badgeContent: Text('$tag', style: GoogleFonts.openSans(color: Colors.black)),
            ),
          )
      ],  
    );
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$_title', style: GoogleFonts.openSans(fontSize: 19.0, fontWeight: FontWeight.w600),),
            Text('Room: $_room', style: GoogleFonts.openSans(fontSize: 14.0),),
            Text('($_date) $_stime - $_etime', style: GoogleFonts.openSans(fontSize: 14.0),),
            if (_tags != null)
              _tagList
          ],
        )
        ),
        trailing: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventDetailScreen(eventId: _eventId)
                )
              );
            },
            splashColor: Colors.black.withOpacity(0.3),
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Icon(FontAwesomeIcons.search, size: 19.0,),
            ),
          )
        ),
      ),
    );
  }
}

class HightlightPainter extends CustomPainter {
  final int _index;
  final _rooms = [
    [
      [
        Offset(21.0, 10.0),
        Offset(7.0, 58.0),
        Offset(30.0, 61.0),
        Offset(44.0, 17.0),
        Offset(21.0, 10.0),
      ],
      [
        Offset(7.0, 58.0),
        Offset(9.0, 70.0),
        Offset(31.0, 73.0),
        Offset(30.0, 61.0),
        Offset(7.0, 58.0),
      ],
      [
        Offset(44.0, 17.0),
        Offset(30.0, 61.0),
        Offset(31.0, 73.0),
        Offset(48.0, 25.0),
        Offset(44.0, 17.0),
      ]
    ],
    [
      [
        Offset(60.0, 11.0),
        Offset(50.0, 31.0),
        Offset(74.0, 40.0),
        Offset(85.0, 16.0),
        Offset(60.0, 11.0),
      ],
      [
        Offset(85.0, 16.0),
        Offset(74.0, 40.0),
        Offset(76.0, 49.0),
        Offset(89.0, 25.0),
        Offset(85.0, 16.0),
      ],
      [
        Offset(50.0, 31.0),
        Offset(50.0, 41.0),
        Offset(76.0, 49.0),
        Offset(74.0, 40.0),
        Offset(50.0, 31.0),
      ]
    ],
    [
      [
        Offset(50.0, 46.0),
        Offset(42.0, 65.0),
        Offset(54.0, 65.0),
        Offset(62.0, 72.0),
        Offset(65.0, 56.0),
        Offset(61.0, 50.0),
        Offset(55.0, 46.0),
        Offset(50.0, 46.0),
      ],
      [
        Offset(42.0, 65.0),
        Offset(46.0, 75.0),
        Offset(61.0, 71.0),
        Offset(68.0, 64.0),
        Offset(65.0, 56.0),
        Offset(62.0, 62.0),
        Offset(54.0, 65.0),
        Offset(42.0, 65.0),
      ]
    ]
  ];

  HightlightPainter({@required int index})
      : _index = index;

  @override
  void paint(Canvas canvas, Size size) {;
    if (_index == null) {
      return;
    }
    Paint paint = new Paint()
      ..color = Color.fromRGBO(197, 197, 0, 0.7)
      ..style = PaintingStyle.fill;
    Path path = new Path();
    _rooms[_index].forEach((List roomPath){
      path.moveTo(roomPath.last.dx / 100 * size.width, roomPath.last.dy / 100 * size.height);
      roomPath.forEach((element) {
        path.lineTo(element.dx / 100 * size.width, element.dy / 100 * size.height);
      });
    });
    // path.moveTo(_rooms[_index].last.dx / 100 * size.width, _rooms[_index].last.dy / 100 * size.height);
    // _rooms[_index].forEach((Offset point) {
    //   path.lineTo(point.dx / 100 * size.width, point.dy / 100 * size.height);
    // });
    canvas.drawPath(path, paint);
    paint
      ..color = Color.fromRGBO(197, 197, 197, 0.6)
      ..strokeWidth = 3.9
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HightlightPainter oldDelegate) {
    return (oldDelegate._index != _index);
  }
}
