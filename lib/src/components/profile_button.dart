import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LXD/src/user_repository.dart';
import 'package:LXD/src/components/login/login.dart';
import 'package:LXD/src/components/register/register.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';

class ProfileButton extends StatefulWidget {
  final UserRepository _userRepository;
  final bool _isSignedIn;

  ProfileButton({Key key, @required UserRepository userRepository, @required bool isSignedIn})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _isSignedIn = isSignedIn,
        super(key: key);

  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  UserRepository get _userRepository => widget._userRepository;
  bool get _isSignedIn => widget._isSignedIn;

  void callLoginForm(BuildContext context) async {
    String result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LoginDialog(userRepository: _userRepository),
        );
      }
    );
    if (result != null) {
      callRegisterForm(context);
    }
  }

  void callLogoutForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: RaisedButton(
            child: Text('click to log out'),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
              Navigator.of(context).pop();
            }
          ),
        );
      }
    );
  }

  void callRegisterForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: RegisterDialog(userRepository: _userRepository),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(_isSignedIn ? 'Click to log out': 'Click to log in'),
      onPressed: () => _isSignedIn ? callLogoutForm(context): callLoginForm(context),
    );
  }
}
