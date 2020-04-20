import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class BookingScreen extends StatefulWidget {
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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

  final List<String> rooms = <String>['A', 'B', 'C', 'D', 'E', 'F'];
  final List<String> entries = <String>[
    'This is event: 1',
    'This is event: 2',
    'This is event: 3',
    'This is event: 4',
    'This is event: 5',
  ];
  final List<int> colorCodes = <int>[600, 500, 100];

  Widget roundedBoxes() {
    return Container(
        width: 325,
        height: 100,
//      margin: EdgeInsets.all(100.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
        child: Center(
          child: Text('Insert event here'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('placeholder'),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
                color: Colors.cyan[100],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 4.0),
                  child: ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                              onTap: () {}, title: Text('${entries[index]}')),
                        );
                      }),
                )),
            Container(
              color: Colors.pinkAccent[100],
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 375,
                    height: 275,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                        image: DecorationImage(
                            image: AssetImage("images/LX_FirstFloorPlan.png"),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('View Events'), icon: Icon(Icons.find_in_page)),
          BottomNavyBarItem(
              title: Text('Find a room'), icon: Icon(Icons.apps)),
          BottomNavyBarItem(
              title: Text('Book!'), icon: Icon(Icons.library_books)),
        ],
      ),
    );
  }
}
