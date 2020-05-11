import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:badges/badges.dart';
import 'package:LXD/src/views/setting_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LXD/src/views/event_add_screen.dart';
import 'package:LXD/src/views/google_map_screen.dart';
import 'package:LXD/src/views/rule_screen.dart';
import 'package:LXD/src/controllers/event/bloc.dart';
import 'package:LXD/src/views/event_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map _currentUser;

  HomeScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map get _currentUser => widget._currentUser;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height,
                ),
                child: PhotoView(
                  backgroundDecoration: BoxDecoration(
                    color: Color.fromRGBO(229, 229, 255, 1.0)
                  ),
                  imageProvider: AssetImage('images/FirstFloorPlan3d.png'),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.5,
                  initialScale: PhotoViewComputedScale.contained * 1.3,
                ),
              ),
              Positioned(
                top: 16.0,
                right: 16.0,
                child: _FloatingButton(),
              ),
              BlocProvider<EventBloc>(
                create: (context) => EventBloc()..add(LoadingStarted()),
                child: _EventSheet(), 
              ),
            ],
          ),
        ),
        endDrawer: SafeArea(
          child: Container(
            width: 250.0,
            child: Drawer(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 250.0,
                    height: 100.0,
                    decoration: BoxDecoration(color: Color.fromRGBO(39, 39, 39, 1.0)),
                    alignment: Alignment.center,
                    child: Image.asset('images/logo_app.png', width: 125.0, height: 50.0),
                  ),
                  SizedBox(height: 24.0,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RuleScreen()
                        )
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Intriguing Information', style: GoogleFonts.openSans(color: Colors.blue),),
                          SizedBox(width: 4.0,),
                          Image.asset('images/ibis/rule_icon.png', width: 36.0, height: 36.0, fit: BoxFit.cover),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  if (_currentUser['email'].toString().indexOf('@mail.kmutt.ac.th') != -1)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EventAddScreen(userId: _currentUser['id'])
                          )
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Create an event', style: GoogleFonts.openSans(color: Colors.blue),),
                            SizedBox(width: 4.0,),
                            Image.asset('images/ibis/event_add_icon.png', width: 36.0, height: 36.0, fit: BoxFit.cover),
                          ],
                        ),
                      ),
                    ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingScreen()
                        )
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Manage your account', style: GoogleFonts.openSans(color: Colors.blue),),
                          SizedBox(width: 4.0),
                          Icon(FontAwesomeIcons.cog, size: 16.0, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0,),
                ],
              ),
            ),
          ),
        ),
      ), 
      onWillPop: () async {
        return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?', style: GoogleFonts.openSans()),
            content: Text('Do you want to exit the app', style: GoogleFonts.openSans()),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ?? false;
      }
    );
  }
}

class _FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.white,
          shape: CircleBorder(),
          child: InkWell(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            splashColor: Colors.black.withOpacity(0.3),
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Icon(FontAwesomeIcons.bars, size: 26.0,),
            ),
          )
        ),
        SizedBox(height: 12.0,),
        Material(
          color: Colors.white,
          shape: CircleBorder(),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('KMUTT Announcements', style: GoogleFonts.openSans(decoration: TextDecoration.underline),),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Important news can be found here!!', style: GoogleFonts.openSans(),),
                      Text('\tCOVID-19: Please stay at your home', style: GoogleFonts.openSans(color: Colors.redAccent),),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Close'),
                    ),
                  ],
                )
              );
            },
            splashColor: Colors.black.withOpacity(0.3),
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Badge(
                position: BadgePosition.bottomRight(bottom: -7.5, right: -5.0),
                badgeContent: Text('N', style: GoogleFonts.openSans(color: Colors.white, fontSize: 9.0)),
                child: Icon(FontAwesomeIcons.bell, size: 26.0,),
              ),
            ),
          )
        ),
        SizedBox(height: 12.0,),
        Material(
          color: Colors.white,
          shape: CircleBorder(),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GoogleMapScreen()
                )
              );
            },
            splashColor: Colors.black.withOpacity(0.3),
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Image.asset('images/ibis/google_map_icon.png', width: 34.0, height: 34.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _EventSheet extends StatefulWidget {
  @override
  __EventSheetState createState() => __EventSheetState();
}

class __EventSheetState extends State<_EventSheet> {
  Timer _debounce;
  @override
  void dispose() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    super.dispose();
  }
  
  void _chooseOneRoom(context, List<Map> roomList) {
    showDialog(
      context: context,
      builder: (innerContext) => AlertDialog(
        title: Text('Choose the room you want', style: GoogleFonts.openSans()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              onPressed: () {
                BlocProvider.of<EventBloc>(context).add(MarkerDismissed());
                Navigator.of(context).pop();
              },
              child: Text('Every room'),
            ),
            for (int i = 0; i < roomList.length; ++i)
              FlatButton(
                onPressed: () {
                  BlocProvider.of<EventBloc>(context).add(MarkerTouched(index: i));
                  Navigator.of(context).pop();
                },
                child: Text('${roomList[i]['name']}'),
              )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Back'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingSheet(
      color: Color.fromRGBO(255, 255, 255, 0.9),
      padding: EdgeInsets.only(top: 8.0, left: 16.0, bottom: 16.0, right: 16.0),
      elevation: 8,
      cornerRadius: 16,
      snapSpec: SnapSpec(
        snap: true,
        snappings: [80, MediaQuery.of(context).size.height * 0.35, MediaQuery.of(context).size.height * 0.8],
        positioning: SnapPositioning.pixelOffset,
      ),
      headerBuilder: (context, state) {
        return Container(
          height: 72.0,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 4.0, width: 55.0, decoration: BoxDecoration(color: Colors.grey[400]),),
              SizedBox(height: 8.0,),
              Expanded(
                child: Center(
                  child: Text(
                    'Upcoming Events',
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold)
                  ),
                )
              )
            ],
          ),
        );
      },
      builder: (context, state) {
        return BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is LoadedEvent) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12.0,),
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show all event in: ', style: GoogleFonts.openSans(color: Colors.black, fontSize: 16.0)),
                      InkWell(
                        onTap: () {
                          _chooseOneRoom(context, state.roomList);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.hasCondition? state.roomList[state.selectedRoomId]['name']: 'Every room',
                              style: GoogleFonts.openSans(color: Colors.blue, fontSize: 16.0)
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(FontAwesomeIcons.caretDown, color: Colors.blue,),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0,),
                  for (Map evt in state.filteredList())
                    _EventCard(
                      title: evt['title'],
                      date: evt['schedule']['date'],
                      room: state.roomList[int.parse(evt['room_id'])]['name'],
                      startTime: evt['schedule']['start_time'],
                      endTime: evt['schedule']['end_time'],
                      eventId: evt['event_id'],
                      tags: evt['tags']
                    ),
                  if (state.filteredList().length == 0)
                    Text('No events found', style: GoogleFonts.openSans(color: Colors.black))
                ],
              );
            }
            return Text('Fetching data...', style: GoogleFonts.openSans(color: Colors.black));
          },
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final String _title, _date, _stime, _etime, _room, _eventId;
  final List _tags;

  _EventCard({@required title, @required date, @required room, @required startTime, @required endTime, @required eventId, @required tags})
      : _title = title, _date = date, _room = room,
        _stime = startTime, _etime = endTime,
        _eventId = eventId, _tags = tags;

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
      color: Color.fromRGBO(255, 255, 255, 1.0),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$_date  $_stime - $_etime', style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.red)),
            Text('$_title', style: GoogleFonts.openSans(fontSize: 19.0, fontWeight: FontWeight.w700),),
            Text('at $_room', style: GoogleFonts.openSans(fontSize: 14.0, color: Color.fromRGBO(69, 69, 69, 1.0)),),
            SizedBox(height: 4.0,),
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
