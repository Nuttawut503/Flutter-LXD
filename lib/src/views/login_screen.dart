import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/api/user_repository.dart';
import 'package:LXD/src/controllers/login/bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: _LoginContent(),
        ),
      ),
    );
  }
}

class _LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<LoginBloc, LoginState>(
    listener: (context, state) {
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
    },
    child: _BackgroundLogin(),
  );
}

class _BackgroundLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Color.fromRGBO(229, 229, 255, 1.0),
      image: DecorationImage(image: AssetImage('images/background_login.png'), fit: BoxFit.cover, alignment: Alignment.bottomRight),
    ),
    child: _SectionLogin(),
  );
}

class _SectionLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150.0,
              height: 60.0,
              child: Image.asset('images/logo_app.png', fit: BoxFit.cover,),
            ),
            SizedBox(height: 24.0,),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'The more I read, the more I acquire,',
                    style: GoogleFonts.openSans(fontSize: 16.0,),
                  ),
                  Text(
                    'the more certain I am that I know nothing.',
                    style: GoogleFonts.openSans(fontSize: 16.0,),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: state.isSubmitting
                      ? null
                      : () {
                        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
                      },
                    child: Text(
                      'Sign in with Google', 
                      style: GoogleFonts.openSans(color: Colors.white, fontSize: 14.0,),
                    ),
                    color: Color.fromRGBO(234, 67, 53, 1.0)
                  ),
                  if (state.isSubmitting)
                    Text('Authenticating...', style: GoogleFonts.openSans(color: Colors.orange, fontSize: 12.0),)
                  else if (state.isSuccess)
                    Text('Sucessed, switching the screen...', style: GoogleFonts.openSans(color: Colors.green, fontSize: 12.0),)
                  else if (state.isFailure)
                    Text('Failed to get the information', style: GoogleFonts.openSans(color: Colors.red, fontSize: 12.0),)
                  else
                    Text('', style: GoogleFonts.openSans(fontSize: 12.0),)
                ]
              ),
            ),
            SizedBox(height: 36.0,),
          ],
        ),
      ),
  );
}

