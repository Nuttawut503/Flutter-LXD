import 'package:flutter/material.dart';
import 'package:LXD/src/user_repository.dart';
import 'package:LXD/src/components/login/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            backgroundColor: Colors.black,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logout Succcess',
                  style: GoogleFonts.openSans(color: Colors.white),
                ), 
                Icon(FontAwesomeIcons.signOutAlt),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSignedIn) {
      return Container(
        height: 75.0,
        width: 75.0,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.black,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) { 
                    callLogoutForm(context);
                  },
                  child: Container(
                    width: 65.0,
                    height: 65.0,
                    child: CachedNetworkImage(
                      imageUrl: '${_currentUser["profile_picture_url"]}',
                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(value: downloadProgress.progress),
                      ), 
                      errorWidget: (context, url, error) => Center(
                        child: Icon(FontAwesomeIcons.exclamationTriangle),
                      ),
                    ),
                  ),
                )                
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: 5.0,
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Icon(FontAwesomeIcons.wrench, color: Colors.white, size: 12.0,),
                ),
              ),
            ),
          ],
        ),
      );
    }  
    return LoginButton(userRepository: _userRepository);
  }
}
