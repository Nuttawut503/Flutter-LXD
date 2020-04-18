import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/user_repository.dart';
import 'package:LXD/src/home_screen.dart';
import 'package:LXD/src/splash_screen.dart';
import 'package:LXD/src/simple_bloc_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate(); // Debugging
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('images/login-bg.jpg'), context);
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return HomeScreen(
              userRepository: _userRepository,
              isSignedIn: false,
            );
          }
          if (state is Authenticated) {
            return HomeScreen(
              userRepository: _userRepository,
              isSignedIn: true,
              user: {
                'id': state.currentUser['id'],
                'name': state.currentUser['name'],
                'email': state.currentUser['email'],
                'profile_picture_url': state.currentUser['profile_picture_url']
              }
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
