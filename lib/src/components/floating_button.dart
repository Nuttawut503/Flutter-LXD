import 'package:flutter/material.dart';
import 'package:LXD/src/api/user_repository.dart';
import 'package:LXD/src/components/login/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/views/render_gmap.dart' as Render_gmap;
import 'package:LXD/src/views/booking_screen.dart';

class FloatingButton extends StatefulWidget {
  final UserRepository _userRepository;
  final bool _isSignedIn;
  final Map _currentUser;

  FloatingButton({Key key, @required UserRepository userRepository, @required bool isSignedIn, Map user})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _isSignedIn = isSignedIn,
        _currentUser = user,
        super(key: key);

  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  UserRepository get _userRepository => widget._userRepository;
  bool get _isSignedIn => widget._isSignedIn;
  Map get _currentUser => widget._currentUser;

  @override
  Widget build(BuildContext context) {
    List<Widget> floatingButtons = [];
    if (!_isSignedIn) {
      floatingButtons.insertAll(0, [
        LoginButton(userRepository: _userRepository,),
        SizedBox(height: 10.0,)
      ]);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: floatingButtons
                  ..add(
                    _ButtonList(
                      isSignedIn: _isSignedIn,
                      user: (_isSignedIn)? _currentUser: null,
                    )
                  ),
    );
  }    
}

class _ButtonList extends StatelessWidget {
  final bool _isSignedIn;
  final Map _currentUser;

  _ButtonList({Key key, @required isSignedIn, Map user})
      : _isSignedIn = isSignedIn,
        _currentUser = user,
        super(key: key);

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
    List<Widget> buttonList = [
      EventButton(),
      SizedBox(height: 5.0,),
      MapButton(),
    ];
    if (_isSignedIn) {
      buttonList
        ..insertAll(2, <Widget>[
          BookingButton(),
          SizedBox(height: 10.0,),
        ])
        ..insertAll(0, [
          SizedBox(height: 10.0,),
          GestureDetector(
            onTap: () { callLogoutForm(context); },
            child: Container(
              width: 46.0,
              height: 46.0,
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
          ),
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0,),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2.0, color: Color.fromRGBO(127, 127, 127, 0.7)))),
          ),
          SizedBox(height: 5.0,),
        ]);
    }
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 10.0,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: buttonList
      ),
    );
  }
}

class EventButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _CustomButton(
    assetImage: 'images/search.png',
    label: 'Events',
    onpressFunction: () => print('events'),
  );
}

class BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _CustomButton(
    assetImage: 'images/booking.png',
    label: 'Booking',
    onpressFunction: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingScreen()));
    },
  );
}

class MapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _CustomButton(
    assetImage: 'images/navigate.png',
    label: 'Location',
    onpressFunction: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Render_gmap.GoToMap()));
    },
  );
}

class _CustomButton extends StatelessWidget {
  final String _assetImage;
  final String _label;
  final Function _onpressFunction;

  _CustomButton({Key key, @required String assetImage, @required String label, @required Function onpressFunction})
      : _assetImage = assetImage,
        _label = label,
        _onpressFunction = onpressFunction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _onpressFunction();
        },
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_assetImage),
                    fit: BoxFit.contain
                  ),
                ),
              ),
              Text(
                '$_label',
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
