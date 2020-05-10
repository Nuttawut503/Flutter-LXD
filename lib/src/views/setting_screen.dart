import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SettingScreen extends StatelessWidget {
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
          child: Column(
            children: [
              _HeaderSetting(),
              _ContentSetting(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 229, 255, 1.0),
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
            'Setting',
            style: GoogleFonts.openSans(fontSize: 19.0)
          ),
          Spacer(),
          Opacity(
            opacity: 0,
            child: Icon(FontAwesomeIcons.arrowLeft, size: 16.0),
          ),
        ]
      ),
    );
  }
}

class _ContentSetting extends StatelessWidget {
  void _signOutDialog(context) async {
    bool result = (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?', style: GoogleFonts.openSans()),
        content: Text('Do you want to sign out', style: GoogleFonts.openSans()),
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
    if (result) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: (context, state) => (state is Authenticated)
    ? Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 48.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(229, 229, 255, 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 54.0, right: 16.0, bottom: 16.0, left: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                        offset: Offset(0, 0),
                      ),
                    ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${state.currentUser['name']}',
                        style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${state.currentUser['email']}',
                        style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w300),
                      )
                    ],
                  )
                ),
                Positioned(
                  top: -35.0,
                  left: 24.0,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: 70.0,
                      height: 70.0,
                      fit: BoxFit.cover,
                      imageUrl: '${state.currentUser["profile_picture_url"]}',
                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(value: downloadProgress.progress),
                      ), 
                      errorWidget: (context, url, error) => Center(
                        child: Icon(FontAwesomeIcons.exclamationTriangle),
                      ),
                    )
                  )
                )
              ],
            ),
            SizedBox(height: 48.0,),
            GestureDetector(
              onTap: () {
                _signOutDialog(context);
              },
              child: Text('Sign out', style: GoogleFonts.openSans(color: Colors.red, fontSize: 17.0)),
            ),
          ],
        ),
      ),
    ): Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(208, 219, 217, 1.0),
      ),
      child: Center(
        child: Text('Something went wrong', style: GoogleFonts.openSans(fontWeight: FontWeight.w300),)
      ),
    )
  );
}
