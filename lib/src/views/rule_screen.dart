import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class RuleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              _HeaderRule(),
              _ContentRule(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderRule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(208, 219, 217, 1.0),
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              splashColor: Colors.black.withOpacity(0.3),
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Icon(FontAwesomeIcons.arrowLeft, size: 16.0),
              ),
            )
          ),
          Spacer(),
          Text(
            'Rules',
            style: GoogleFonts.openSans(fontSize: 19.0)
          ),
          Spacer(),
          Opacity(
            opacity: 0,
            child: Icon(FontAwesomeIcons.arrowLeft, size: 16.0),
          ),
        ]
      ),
    );
  }
}

class _ContentRule extends StatelessWidget {
  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) => BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: (context, state) => (state is Authenticated)
    ? Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 48.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(208, 219, 217, 1.0),
        ),
        child: PageView(
          controller: _controller,
          children: [
            Container(
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 200.0,
                      width: 350.0,
                      child: Carousel(
                        images: [
                          Image.asset('images/logo_app.png'),
                          Image.network('https://cdn.myanimelist.net/s/common/uploaded_files/1452233251-a47793a705e917c1754afd47cda99d9f.jpeg'),
                        ],
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Colors.lightGreenAccent,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.pinkAccent.withOpacity(0.5),
                        borderRadius: true,
                      )
                  ),
                  SizedBox(height: 25,),
                  Text('General Regulations', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: () => _popupDialog(context),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.assignment, size: 55,),
                        title: Text('Credit Assesments'),
                        subtitle: Text(
                            'Wonder how much credits you should be taking?'
                        ),
                        isThreeLine: true,
                        trailing: Icon(Icons.more_vert),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            Container(
              color: Colors.cyan,
            ),
            Container(
              color: Colors.deepPurpleAccent,
            ),
          ],
        ),
      ),
    ): Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(208, 219, 217, 1.0),
      ),
      child: Center(
        child: Text('Something went wrong', style: GoogleFonts.openSans(fontWeight: FontWeight.w300),)
      ),
    )
  );

  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert Dialog Example !!!'),
            content: Text('Alert Dialog Body Goes Here  ..'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close')),
            ],
          );
        });
  }
}
