import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/api/user_repository.dart';
import 'package:LXD/src/views/home_screen.dart';
import 'package:LXD/src/views/splash_screen.dart';
import 'package:LXD/simple_bloc_delegate.dart';
import 'package:LXD/src/views/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate(); // Debugging will be remove later.
  final UserRepository userRepository = UserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          )..add(AppStarted()),
        ),
      ],
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          if (state is Authenticated) {
            return HomeScreen(
              userRepository: _userRepository,
              currentUser: state.currentUser,
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
