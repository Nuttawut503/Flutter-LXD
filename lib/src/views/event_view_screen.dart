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

class _EventViewState extends State<_EventView> {
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
                  for (Map evt in state.eventList.where((el) => el['title'].toString().toLowerCase().indexOf(state.textFilter.toLowerCase()) != -1))
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
