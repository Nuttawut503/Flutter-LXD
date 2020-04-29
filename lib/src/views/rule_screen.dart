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
                  SizedBox( width: 500, height: 300,
                    child: ListView(
                      children: <Widget>[
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 1),
                            leading: Icon(Icons.assignment, size: 55, color: Colors.deepPurpleAccent,),
                            title: Text('Credit Assesments'),
                            subtitle: Text(
                                'Wonder how much credits you should be taking?'
                            ),
                            isThreeLine: true,
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 2),
                            leading: Icon(Icons.priority_high, size: 55, color: Colors.cyan,),
                            title: Text('Withdrawing Courses'),
                            subtitle: Text(
                                'How do I withdraw from certain courses?'
                            ),
                            isThreeLine: true,
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Card(
                          child: ListTile(
                            onTap: () => _popupDialog(context, 3),
                            leading: Icon(Icons.grade, size: 55, color: Colors.pinkAccent,),
                            title: Text('Grading System'),
                            subtitle: Text(
                                'Wonder what grade and how well you\'ll get?'
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

  void _popupDialog(BuildContext context,number) {
    if(number == 1){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('The number of credits for each semester'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('${ruleDetails[0]}'),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
                    SizedBox(height: 10,),
                    Text('${ruleDetails[1]}'),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
                    SizedBox(height: 10,),
                    Text('${ruleDetails[2]}'),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
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
              title: Text('Dropping information'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('${ruleDetails[3]}'),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
                    SizedBox(height: 10,),
                    Text('${ruleDetails[4]}'),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
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
              title: Text('Dropping information'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('${ruleDetails[5]}'),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
                    SizedBox(height: 10,),
                    Text('${ruleDetails[6]}'),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
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
  List<String> ruleDetails = ["Students are allowed to register with a minimum of 12 credits and a maximum of 19 credits in each regular semester. Exceptions can be approved in accordance with the program regulations.",
    "Students who register for less than the minimum or more than the maximum required must receive approval from their academic advisor, but this must not exceed 3 credits" +
  "and the total credits must not exceed 22 credits per regular semester." +
  "In the case that students have to register less than or exceed the number of credits mentioned in the first paragraph, they must be granted the approval from the head of department and the Faculty Committee.",
  "Students must not register in courses which overlap study hours and examination" +
  "hours, except for the following exceptions may register in courses which overlap examination hours with the approval of their academic advisor;",
  "Dropping can be done before the midterm examination for a regular semester or within the first two weeks of instruction for a special semester with the approval from the academic advisor. The result of dropped courses will not appear in the academic record." +
  "The university will give an 80% refund to students who drop from a course during the first two weeks of instruction for a regular semester or within the first week of instruction for a special semester, except for students who are studying in the commutation program.",
  "A request for withdrawing from courses must be processed 3 weeks before the final" +
  "examination for a regular semester. For a special semester, it must be processed after two weeks, but not later than the first 4 weeks of instruction. The withdrawn courses will appear as ‘W’ in the academic record.",
  "Students whose attendance is less than 80% will receive ‘Fa’ from that course and this grade will be calculated in the student’s GPA of that semester and the cumulative GPA, except cumulative GPA calculation that includes repeated courses as mentioned in 28.3.",
  "If students fail to attend the examination, they will receive ‘Fe’ from that course and this grade will be calculated in the student’s GPA of that semester, except cumulative GPA calculation that includes of repeated courses as mentioned in 28.3." +
  "Students who fail to attend the examination due to reasons mentioned in item 50.2 will be considered by the Faculty Committee."];
}
