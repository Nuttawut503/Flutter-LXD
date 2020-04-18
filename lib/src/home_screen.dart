import 'package:flutter/material.dart';
import 'package:LXD/src/user_repository.dart';
import 'package:LXD/src/components/profile_button.dart';
import 'package:LXD/src/components/floating_button.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:LXD/src/components/render_gmap.dart' as render_gmap;

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
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  donutWidget(){
    return new Stack(
      children: <Widget>[
        Container(decoration: BoxDecoration(color: Color.fromRGBO(255, 199, 44, 1.0)),),
        Positioned(
            top: 16.0,
            left: 16.0,
            child: ProfileButton(
              userRepository: _userRepository,
              isSignedIn: _isSignedIn,
              user: _currentUser,
            )
        ),
        Positioned(
            top: 16.0,
            right: 16.0,
            child: FloatingButton()
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Container(color: Colors.blueGrey,),
              donutWidget(),
              render_gmap.goToMap.return_gmap(),
//              Container(color: Colors.red,),

//              Container(color: Colors.green,),
              Container(color: Colors.blue,),
            ],
          ),
        ],
      ),

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.apps)
          ),
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.chat_bubble)
          ),
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.settings)
          ),
        ],
      ),
    );
  }
}

