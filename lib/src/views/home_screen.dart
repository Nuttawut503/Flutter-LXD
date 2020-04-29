import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:LXD/src/api/user_repository.dart';
import 'package:LXD/src/views/setting_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LXD/src/views/building_plan_screen.dart';
import 'package:LXD/src/views/event_add_screen.dart';
import 'package:LXD/src/views/event_view_screen.dart';
import 'package:LXD/src/views/google_map_screen.dart';
import 'package:LXD/src/views/rule_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map _currentUser;

  HomeScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _HeaderHome(currentUser: _currentUser),
            Flexible(
              child: ListView(
                children: [
                  _ContentHome(currentUser: _currentUser)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderHome extends StatelessWidget {
  final Map _currentUser;

  _HeaderHome({Key key, @required Map currentUser})
      : _currentUser = currentUser;

  void _getAnnoucementDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ummm...?'),
        content: Text('This might be used for seeking announments from KMUTT ( ͡° ʖ̯ ͡°)'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(208, 219, 217, 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 60.0,
            height: 30.0,
            child: Image.asset('images/logo_app.png', fit: BoxFit.fill),
          ),
          Spacer(),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _getAnnoucementDialog(context);
              },
              splashColor: Colors.black.withOpacity(0.3),
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Icon(FontAwesomeIcons.bell),
              ),
            )
          ),
          SizedBox(width: 16.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingScreen()
                )
              );
            },
            child: ClipOval(
              child: CachedNetworkImage(
                width: 36.0,
                height: 36.0,
                fit: BoxFit.cover,
                imageUrl: '${_currentUser["profile_picture_url"]}',
                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                  child: CircularProgressIndicator(value: downloadProgress.progress),
                ), 
                errorWidget: (context, url, error) => Center(
                  child: Icon(FontAwesomeIcons.exclamationTriangle),
                ),
              ),
            )
          )
        ]
      ),
    );
  }
}

class _ContentHome extends StatelessWidget {
  final Map _currentUser;

  _ContentHome({Key key, @required Map currentUser})
      : _currentUser = currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color.fromRGBO(208, 219, 217, 1.0)),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exchange your knowledge',
            style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w900),
          ),
          Text(
            'There are many events you can join in LX@KMUTT',
            style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16.0,),
          Container(
            height: 250.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EventViewScreen()
                          )
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.only(top: 12.0, right: 8.0, bottom: 12.0, left: 24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39.0),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(0, 131, 176, 1.0), Color.fromRGBO(0, 180, 219, 1.0)]
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 131, 176, 0.5),
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Text(
                              'Be an attendee',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300,),
                            ),
                            Text(
                              'Events &',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Text(
                              'Activities',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Image.asset(
                              'images/ibis/event_view_icon.png',
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.cover
                            ),
                          ],
                        ),
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EventAddScreen(userId: _currentUser['id'])
                          )
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.only(top: 12.0, right: 8.0, bottom: 12.0, left: 24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39.0),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(137, 33, 107, 1.0), Color.fromRGBO(218, 68, 83, 1.0)]
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(137, 33, 107, 0.5),
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Text(
                              'Be an attendant',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300,),
                            ),
                            Text(
                              'Create a',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Text(
                              'schedule',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Image.asset(
                              'images/ibis/event_add_icon.png',
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.cover
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16.0,),
          Text(
            'Suggestions?',
            style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w900),
          ),
          Text(
            'Some guidelines and helpful information',
            style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16.0,),
          Container(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RuleScreen()
                          )
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.only(top: 12.0, right: 8.0, bottom: 12.0, left: 24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39.0),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(247, 151, 30, 1.0), Color.fromRGBO(255, 210, 0, 1.0)]
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(247, 151, 30, 0.5),
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Text(
                              'To be on the same page',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300,),
                            ),
                            Text(
                              'Set of',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Text(
                              'Regulations',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Image.asset(
                              'images/ibis/rule_icon.png',
                              width: 96.0,
                              height: 96.0,
                              fit: BoxFit.cover
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BuildingPlanScreen()
                          )
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.only(top: 12.0, right: 8.0, bottom: 12.0, left: 24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39.0),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(0, 176, 155, 1.0), Color.fromRGBO(150, 201, 61, 1.0)]
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 176, 155, 0.5),
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Text(
                              'For preparation',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300,),
                            ),
                            Text(
                              'LX@KMUTT',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Text(
                              'Building plan',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Image.asset(
                              'images/ibis/building_plan_icon.png',
                              width: 96.0,
                              height: 96.0,
                              fit: BoxFit.cover
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GoogleMapScreen()
                          )
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.only(top: 12.0, right: 8.0, bottom: 12.0, left: 24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39.0),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(106, 48, 147, 1.0), Color.fromRGBO(160, 68, 255, 1.0)]
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(106, 48, 147, 0.5),
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Text(
                              'Equip your weapons',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300,),
                            ),
                            Text(
                              'Route on',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Text(
                              'Google Map',
                              style: GoogleFonts.openSans(color: Colors.white, fontSize: 25.0,),
                            ),
                            Image.asset(
                              'images/ibis/google_map_icon.png',
                              width: 96.0,
                              height: 96.0,
                              fit: BoxFit.cover
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
