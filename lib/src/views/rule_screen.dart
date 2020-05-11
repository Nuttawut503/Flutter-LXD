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
                    Text('นักศึกษาชาย' +
                    '\n \n-เสื้อ เสื้อเชิ้ตสีขาว แขนสั้น หรือแขนยาว สอดชายเสื้อในกางเกง' +
                    '\n \n-กางเกง ขายาว สีและแบบสุภาพ มีหูเข็มขัด' +
                    '\n \n-เข็มขัด หนังสีดำหรือสีน้ำตาล หัวเข็มขัดรูปเครื่องหมายมหาวิทยาลัย' +
                    '\n \n-รองเท้า หุ้มส้น แบบและสีสุภาพ', textAlign: TextAlign.left,),
                    SizedBox(height: 10,),
                    Text('-----------------------------------------------------------'),
                    SizedBox(height: 10,),
                    Text('นักศึกษาหญิง' +
                    '\n \n-เสื้อเชิ้ตสีขาวแขนสั้น ผ่าหน้าตลอด ติดกระดุมเครื่องหมายมหาวิทยาลัย' +
                        '\n \n-5 เม็ด เวลาสวมให้สอดชายเสื้อไว้ในกระโปรง มีเข็มเครื่องหมาย มหาวิทยาลัย ติดอกเสื้อด้านซ้าย' +
                      '\n \n-กระโปรง สีกรมท่า สีดำ สีน้ำตาล สีเทา ความยาวคลุมเข่า' +
                      '\n \n-เข็มขัด สีดำหรือสีน้ำตาล หัวเข็มขัดรูปเครื่องหมายมหาวิทยาลัย' +
                      '\n \n-รองเท้า หุ้มส้น สีและแบบสุภาพ'),
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
                        "\n\nอาคารการเรียนรู้พหุวิทยาการเป็นอาคารที่มีการออกแบบให้สอดคล้องกับการเรียนการสอนในรูปแบบใหม่ ที่กล่าวถึงการสร้างสภาพแวดล้อมให้เหมาะสมกับการเรียนรู้ทั้งในและนอกห้องเรียน (Learning and Living Campus) ตามที่มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรีมีเป้าหมายในการพัฒนาและปรับปรุงกระบวนการเรียนการสอน สนับสนุนให้ผู้ใช้งานอาคาร สามารถรับรู้สารสนเทศพหุวิทยาการโดยอาศัยเทคโนโลยีการสื่อสารและสารสนเทศ (Information  and Communication Technology)"),
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
                      '\n\nพื้นที่อเนกประสงค์สำหรับกิจกรรมต่างๆ รองรับผู้ใช้สอยได้ 30-40 คน Multi-Disciplinary Workshop/ Lab Space พื้นที่อเนกประสงค์ที่มีอุปกรณ์รองรับการปฏิบัติการและการวิจัยแบบสหวิทยาการ รวมทั้งเป็นพื้นที่พัฒนา Collaborative Working Space พื้นที่สำหรับเรียนรู้ร่วมกันอย่างไม่เป็นทางการ มีลักษณะเป็น Lounge หรือพื้นที่ในแนวทางสัญจร'),
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
                        '\n\nพพื้นที่อเนกประสงค์สำหรับกิจกรรมต่างๆ รองรับผู้ใช้สอยได้ 30-40 คน Multi-Disciplinary Workshop/ Lab Space พื้นที่อเนกประสงค์ที่มีอุปกรณ์รองรับการปฏิบัติการและการวิจัยแบบสหวิทยาการ รวมทั้งเป็นพื้นที่พัฒนา บุคลากรส่งเสริมการเรียนรู้ให้เกิดทักษะเฉพาะทาง Collaborative Working Space พื้นที่สำหรับเรียนรู้ร่วมกันอย่างไม่เป็นทางการ มีลักษณะเป็น Lounge หรือพื้นที่ในแนวทางสัญจ'),
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
                        '\n\nห้องควบคุมระบบข้อมูลต่างๆ ของมหาวิทยาลัย เนื่องจากอาคารนี้จะต้องเป็น Interactive Data Center คือสามารถสืบค้น สร้างสรรค์ และจัดเก็บข้อมูลที่เกี่ยวเนื่องกับการประสานการเรียนรู้ ผ่านทางระบบอินเตอร์เน็ต ระบบ Data Center จึงมีความสำคัญมากและเป็นเสมือนคลังสมองของมหาวิทยาลัย และที่ขาดไม่ได้คืองานระบบประกอบอาคาร และสำนักงานเจ้าหน้าที่ ที่อำนวยการให้อาคารสามารถใช้งานได้อย่างมีประสิทธิภาพนอกจากเรื่องการเรียนการสอน รูปแบบใหม่แล้ว มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรียังมีความต้องการพื้นที่รองรับนักศึกษาและเจ้าหน้าที่ที่มีจำนวนเพิ่มขึ้น สำหรับ 2 หน่วยงาน คือ สำนักคอมพิวเตอร์ และคณะเทคโนโลยีสารสนเทศ ซึ่งออกแบบให้อยู่บริเวณพื้นที่ชั้นบนของอาคาร'),
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
