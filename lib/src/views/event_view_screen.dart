import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/controllers/event/bloc.dart';
import 'package:LXD/src/views/event_detail_screen.dart';
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
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<_EventView> {
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
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(color: Colors.red),
              ),
            ),
            SizedBox(height: 12.0,),
            Expanded(
              child: ListView(
                children: [
                  for (Map ev in state.eventList)
                    _EventCard(
                      title: ev['title'],
                      date: ev['schedule']['date'],
                      room: state.roomList[int.parse(ev['room_id'])]['name'],
                      startTime: ev['schedule']['start_time'],
                      endTime: ev['schedule']['end_time'],
                      eventId: ev['event_id'],
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

class _EventCard extends StatelessWidget {
  final String _title, _date, _stime, _etime, _room, _eventId;

  _EventCard({@required title, @required date, @required room, @required startTime, @required endTime, @required eventId})
      : _title = title,
        _date = date,
        _room = room,
        _stime = startTime,
        _etime = endTime,
        _eventId = eventId;

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
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$_title', style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
            Text('Room: $_room', style: GoogleFonts.openSans(fontSize: 14.0),),
            Text('($_date) $_stime - $_etime', style: GoogleFonts.openSans(fontSize: 14.0),),
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
