import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LXD/src/user_repository.dart';
import 'package:LXD/src/components/login/login.dart';
import 'package:LXD/src/components/login/logout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileButton extends StatefulWidget {
  final UserRepository _userRepository;
  final bool _isSignedIn;
  final Map _currentUser;

  ProfileButton({Key key, @required UserRepository userRepository, @required bool isSignedIn, Map user})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _isSignedIn = isSignedIn,
        _currentUser = user,
        super(key: key);

  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  UserRepository get _userRepository => widget._userRepository;
  bool get _isSignedIn => widget._isSignedIn;
  Map get _currentUser => widget._currentUser;

  void callLoginForm(BuildContext context) async {
    String returnText = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LoginDialog(userRepository: _userRepository),
        );
      }
    );
    if (returnText == 'isSuccess') {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: CustomSnac(
              text: 'Login Success',
              icon: FontAwesomeIcons.batteryFull
            )
          ),
        );
    } else if (returnText == 'isFailure') {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: CustomSnac(
              text: 'Login Fail',
              icon: FontAwesomeIcons.crosshairs
            )
          ),
        );
    }
  }

  void callLogoutForm(BuildContext context) async {
    String returnText = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LogoutDialog(user: _currentUser)
        );
      }
    );
    if (returnText == 'loggedOut') {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.blueAccent,
            content: CustomSnac(
              text: 'Logout sucess',
              icon: FontAwesomeIcons.smile
            )
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(_isSignedIn ? 'Click to log out': 'Click to log in'),
      onPressed: () => _isSignedIn ? callLogoutForm(context): callLoginForm(context),
    );
  }
}

class CustomSnac extends StatelessWidget {
  final String _text;
  final IconData _icon;

  CustomSnac({Key key, @required String text, @required IconData icon})
      : _text = text,
        _icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _text,
          style: GoogleFonts.openSans(color: Colors.white),
        ), 
        Icon(_icon)
      ],
    );
  }
}
