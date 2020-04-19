import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';

class LogoutDialog extends StatelessWidget {
  final Map _currentUser;

  LogoutDialog({Key key, @required Map user})
      : _currentUser = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 250.0,
          height: 200.0,
          child: Image.asset(
            'images/login-bg.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        SizedBox(height: 16.0,),
        Text(
          'You are signed in as',
          style: GoogleFonts.openSans(),
        ),
        Text(
          '${_currentUser["email"]}',
          style: GoogleFonts.openSans(fontSize: 13.0),
        ),
        SizedBox(height: 16.0,),
        LogoutButton(),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(FontAwesomeIcons.signOutAlt, color: Colors.redAccent),
          SizedBox(width: 10.0,),
          Text(
            'Log out',
            style: GoogleFonts.openSans(color: Colors.redAccent),
          ),
        ],
      ),
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(
          LoggedOut(),
        );
        Navigator.of(context).pop('loggedOut');
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),),
      borderSide: BorderSide(
        width: 1.0,
        color: Colors.redAccent,
      ),
    );
  }
}
