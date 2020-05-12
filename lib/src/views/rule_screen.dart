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
        color: Color.fromRGBO(229, 229, 255, 1.0),
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
            'Intriguing information',
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
          color: Color.fromRGBO(229, 229, 255, 1.0),
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
                          Image.network('https://ene.kmutt.ac.th/wp-content/uploads/2019/01/49708661_309802466316862_8938973613344686080_n.jpg', fit: BoxFit.cover,),
                          Image.network('https://lh3.googleusercontent.com/proxy/RJnnldzuxEQ0yiKEitCrCt4u-CgPCE8rvmAlU2-XU-ouiyLI8iU3_bucW_fDmBH8jIitZA-zNr7SprIyhLfaB_99NrYz0nczX5Do0DjdOOQuoYUMEA5hfm9OpyY'),
//                          Image.network('https://cdn.myanimelist.net/s/common/uploaded_files/1452233251-a47793a705e917c1754afd47cda99d9f.jpeg'),
                        ],
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Colors.yellow,
                        indicatorBgPadding: 5.0,
//                        dotBgColor: Colors.deepOrangeAccent.withOpacity(0.5),
                        borderRadius: true,
                      )
                  ),
                  SizedBox(height: 25,),
                  Text('LX information', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
                  SizedBox(height: 15,),
                  SizedBox( width: 500, height: 300,
                    child: ListView(
                      children: <Widget>[
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 2),
                            leading: Icon(Icons.priority_high, size: 55, color: Colors.cyan,),
                            title: Text('What is LX?'),
                            subtitle: Text(
                                'Wonder why and how LX was created?'
                            ),
                            isThreeLine: true,
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 1),
                            leading: Icon(Icons.accessibility_new, size: 55, color: Colors.deepPurpleAccent,),
                            title: Text('General outfits'),
                            subtitle: Text(
                                'Wonder what to wear when entering LX?'
                            ),
                            isThreeLine: true,
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 3),
                            leading: Icon(Icons.apps, size: 55, color: Colors.pinkAccent,),
                            title: Text('Flip Classroom'),
                            subtitle: Text(
                                'What\'s a flip classroom, and what is the purpose of it?'
                            ),
                            isThreeLine: true,
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 4),
                            leading: Icon(Icons.blur_circular, size: 55, color: Colors.deepOrangeAccent,),
                            title: Text('Public Space'),
                            subtitle: Text(
                                'What\'s a public space, and what can we do with it?'
                            ),
                            isThreeLine: true,
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 5),
                            leading: Icon(Icons.highlight, size: 55, color: Colors.yellow,),
                            title: Text('Learning Support'),
                            subtitle: Text(
                                'Wonder why the room is called learning support?'
                            ),
                            isThreeLine: true,
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
//              color: Colors.cyan,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: 500.0,
                      width: 300.0,
                      child: Carousel(
                        boxFit: BoxFit.cover,
                        images: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://www.halfbakedharvest.com/wp-content/uploads/2018/05/Weeknight-20-Minute-Spicy-Udon-Noodles-1-700x1050.jpg'),
                                    fit: BoxFit.cover
                                )
                            ),
                            child:  Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 400,
                                  left: 140,
                                  child: Text('Noodles', style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Positioned(
                                  top: 440,
                                  left: 220,
                                  child: Text('@KFC', style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://www.justonecookbook.com/wp-content/uploads/2018/11/Easy-Fried-Rice-I.jpg'),
                                    fit: BoxFit.fitHeight
                                )
                            ),
                            child:  Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 400,
                                  left: 125,
                                  child: Text('Fried rice', style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Positioned(
                                  top: 440,
                                  left: 190,
                                  child: Text('@เจ้-porn', style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://www.siammakro.co.th/imgadmins/img_detail_food/th/142545.jpg'),
                                fit: BoxFit.fitHeight
                              )
                            ),
                            child:  Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 400,
                                  left: 75,
                                  child: Text('BrownSugar', style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Positioned(
                                  top: 440,
                                  left: 115,
                                  child: Text('@ลุ่งหนุ่ม-square', style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://media-cdn.tripadvisor.com/media/photo-s/15/c5/a4/14/pepperoni-lovers.jpg'),
                                    fit: BoxFit.cover
                                )
                            ),
                            child:  Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 400,
                                  left: 200,
                                  child: Text('Pizza', style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Positioned(
                                  top: 440,
                                  left: 175,
                                  child: Text('PizzaComp', style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ],
                            ),
                          ),
                        ],
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Colors.lightGreenAccent,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.pinkAccent.withOpacity(0.5),
                        borderRadius: true,
                      )
                  ),
                  SizedBox(height: 20,),
                  Text('Food near the area', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
                ],
              ),
            ),
            Container(
//              color: Colors.deepPurpleAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('More interesting stuff comming soon', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
              ],
            ),
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

  void _popupDialog(BuildContext context,number) {
    if(number == 1){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Outfit Regulations'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Male Student' +
                    '\n \n -White shirt with short sleeves or long sleeves with hem in the pants' +
                    '\n \n-Long pants in polite style and with belt buckle' +
                    '\n \n-Black or brown leather belt with university shaped buckle' +
                    '\n \n-Brogue shoes with polite colors', textAlign: TextAlign.left,),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
                    SizedBox(height: 10,),
                    Text('Female Student' +
                    '\n \n-White shirt, short sleeves, all over the front, buttoning up with the university logo' +
                        '\n \n-5 beads when wearing, put the hem in the skirt There is a university pin on the left chest.' +
                      '\n \n-Dark black, brown, gray skirt, knee length' +
                      '\n \n-Black or brown belt with university shaped buckle' +
                      '\n \n-Brogan shoes with polite colors'),
                    SizedBox(height: 10,),
//                    SizedBox(height: 10,),
//                    Text('${ruleDetails[2]}'),
//                    SizedBox(height: 10,),
//                    Text('-----------------------------------------------------------'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close')),
              ],
            );
          });
    }
    else if(number == 2){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Origin of LX'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text("Project background :" +
                        "\n\nThe Multidisciplinary Learning Building is a building designed in accordance with the new teaching and learning style. That describes creating a suitable environment for learning both in and out of the classroom (Learning and Living Campus) as King Mongkut's University of Technology Thonburi aims to develop and improve the teaching and learning process Support building users Able to perceive multidisciplinary information through information and communication technology"),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close')),
              ],
            );
          });
    }
    else if(number == 3){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Details about Flip-Classroom'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Flip-Classroom' +
                      '\n\nMultipurpose area for various activities Accommodate up to 30-40 people. Multi-Disciplinary Workshop / Lab Space A multipurpose space with interdisciplinary operations and research equipment. Including a development area Collaborative Working Space, an informal space for shared learning, is a lounge or traveling area.'),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close')),
              ],
            );
          });
    }
    else if(number == 4){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Details about Public Space'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Public Space' +
                        '\n\nพA multipurpose space for various activities Accommodate up to 30-40 people. Multi-Disciplinary Workshop / Lab Space A multipurpose space with interdisciplinary operations and research equipment. Including a development area Personnel promote learning to create specific skills. Collaborative Working Space, an informal space for shared learning, is a lounge or space in the contract guidelines.'),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close')),
              ],
            );
          });
    }
    else if(number == 5){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Details about Learning Support'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Learning Support' +
                        '\n\nInformation system control room Of the university Because this building must be an Interactive Data Center which is able to search, create and store information related to learning coordination. Through the Internet, the Data Center system is very important and is like the brain of the university. And that is indispensable is the building assembly system And office staff That allows the building to be used effectively.'),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close')),
              ],
            );
          });
    }
  }
}
