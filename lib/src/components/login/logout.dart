import 'package:flutter/material.dart';
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
        Text(
          'You are signed in as',
          style: GoogleFonts.openSans(),
        ),
        Text(
          '${_currentUser["email"]}',
          style: GoogleFonts.openSans(fontSize: 13.0),
        ),
        RaisedButton(
          child: Text(
            'log out',
            style: GoogleFonts.openSans(color: Color.fromRGBO(255, 0, 0, 1.0)),
          ),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              LoggedOut(),
            );
            Navigator.of(context).pop('loggedOut');
          }
        ),
      ],
    );
  }
}
