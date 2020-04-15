import 'package:flutter/material.dart';
import 'package:LXD/src/user_repository.dart';
import 'package:LXD/src/components/profile_button.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final bool _isSignedIn;

  HomeScreen({Key key, @required UserRepository userRepository, @required bool isSignedIn})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _isSignedIn = isSignedIn,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: ProfileButton(
              userRepository: _userRepository,
              isSignedIn: _isSignedIn,
            ),
          ),
        ],
      ),
    );
  }
}
