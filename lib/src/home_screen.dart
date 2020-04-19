import 'package:flutter/material.dart';
import 'package:LXD/src/user_repository.dart';
import 'package:LXD/src/components/floating_button.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final bool _isSignedIn;
  final Map _currentUser;

  HomeScreen({Key key, @required UserRepository userRepository, @required bool isSignedIn, Map user})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _isSignedIn = isSignedIn,
        _currentUser = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: HomeContent(
          userRepository: _userRepository,
          isSignedIn: _isSignedIn,
          user: _currentUser,
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final UserRepository _userRepository;
  final bool _isSignedIn;
  final Map _currentUser;

  HomeContent({Key key, @required UserRepository userRepository, @required bool isSignedIn, Map user})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _isSignedIn = isSignedIn,
        _currentUser = user,
        super(key: key);
  
  State<HomeContent> createState()  => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  UserRepository get _userRepository => widget._userRepository;
  bool get _isSignedIn => widget._isSignedIn;
  Map get _currentUser => widget._currentUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(decoration: BoxDecoration(color: Color.fromRGBO(255, 199, 44, 1.0)),),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: FloatingButton(
            userRepository: _userRepository,
            isSignedIn: _isSignedIn,
            user: _currentUser,
          )
        ),
      ],
    );
  }
}
