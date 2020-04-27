import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/controllers/booking/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventAddScreen extends StatelessWidget {
  final String _userId;

  EventAddScreen({Key key, @required String userId})
      : _userId = userId;

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
          child: BlocProvider<BookingBloc>(
            create: (context) => BookingBloc(userId: _userId)..add(LoadingStarted()),
            child: Column(
              children: [
                _HeaderEventAdd(),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: _SectionEventAdd(),
                  )
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}

class _HeaderEventAdd extends StatelessWidget {
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
            'Add Event',
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

class _SectionEventAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color.fromRGBO(208, 219, 217, 1.0)),
      child: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state.isSuccess) {
            print('successed');
            // Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _FormEventAdd();
            }
          },
        )
      )
    );
  }
}

class _FormEventAdd extends StatefulWidget {
  @override
  _FormEventAddState createState() => _FormEventAddState();
}

class _FormEventAddState extends State<_FormEventAdd> {
  final _pageFormController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageFormController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: _FormFirstPage(pageFormController: _pageFormController),
        ),
        Center(
          child: _FormSecondPage(pageFormController: _pageFormController),
        ),
        Center(
          child: _FormThirdPage(pageFormController: _pageFormController),
        ),
      ],
    );
  }
}

class _FormFirstPage extends StatefulWidget {
  final PageController _pageFormController;
  
  _FormFirstPage({@required PageController pageFormController})
      : _pageFormController= pageFormController;

  @override
  State<_FormFirstPage> createState() => _FormFirstPageState();
}

class _FormFirstPageState extends State<_FormFirstPage> {
  PageController get _pageFormController => widget._pageFormController;
  Timer _debounce;

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(max(300, MediaQuery.of(context).size.width * 0.75), 800),
      alignment: Alignment(0, -0.2),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 16.0),
        children: [
          Text('Title', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600), textAlign: TextAlign.left,),
          SizedBox(height: 8.0,),
          TextFormField(
            maxLength: 30,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              if (_debounce?.isActive ?? false) _debounce.cancel();
              _debounce = Timer(Duration(milliseconds: 900), () {
                print(text);
              });
            },
            style: GoogleFonts.openSans(fontSize: 19.0),
            decoration: InputDecoration(
              hintText: 'Title of your event',
              hintStyle: GoogleFonts.openSans(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
                borderSide: BorderSide(
                  width: 0, 
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          SizedBox(height: 16.0,),
          Text('Detail', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600), textAlign: TextAlign.left,),
          SizedBox(height: 8.0,),
          TextFormField(
            maxLength: 150,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            onChanged: (text) {
              if (_debounce?.isActive ?? false) _debounce.cancel();
              _debounce = Timer(Duration(milliseconds: 900), () {
                print(text);
              });
            },
            style: GoogleFonts.openSans(),
            decoration: InputDecoration(
              hintText: 'Information of your event',
              hintStyle: GoogleFonts.openSans(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
                borderSide: BorderSide(
                  width: 0, 
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          SizedBox(height: 16.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                onPressed: () {
                  _pageFormController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Text('Next', style: GoogleFonts.openSans()),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _FormSecondPage extends StatefulWidget {
  final PageController _pageFormController;
  
  _FormSecondPage({@required PageController pageFormController})
      : _pageFormController= pageFormController;

  @override
  State<_FormSecondPage> createState() => _FormSecondPageState();
}

class _FormSecondPageState extends State<_FormSecondPage> {
  PageController get _pageFormController => widget._pageFormController;
  TextEditingController _tagFieldController = TextEditingController();

  @override
  void dispose() {
    _tagFieldController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(max(300, MediaQuery.of(context).size.width * 0.75), 800),
      alignment: Alignment(0, -0.2),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 16.0),
        children: [
          Text('Tags (Optional: up to 5)', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600), textAlign: TextAlign.left,),
          Text('Use this to grab attention', style: GoogleFonts.openSans(fontWeight: FontWeight.w300), textAlign: TextAlign.left,),
          SizedBox(height: 24.0,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  controller: _tagFieldController,
                  style: GoogleFonts.openSans(fontSize: 19.0),
                  decoration: InputDecoration(
                    hintText: 'Type here',
                    hintStyle: GoogleFonts.openSans(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                      borderSide: BorderSide(
                        width: 0, 
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              SizedBox(width: 12.0,),
              RaisedButton(
                onPressed: () {
                  print(_tagFieldController.text);
                },
                child: Text('ADD', style: GoogleFonts.openSans()),
              )
            ]
          ),
          SizedBox(height: 16.0,),
          for (int i = 0; i < 5; ++i)
              _TagItem(index: i, value: 'test', shouldActivate: i < 5),
          SizedBox(height: 16.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                onPressed: () {
                  _pageFormController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Text('Prev', style: GoogleFonts.openSans()),
              ),
              RaisedButton(
                onPressed: () {
                  _pageFormController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Text('Next', style: GoogleFonts.openSans()),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TagItem extends StatelessWidget {
  final int _index;
  final String _value;
  final bool _shoudActivate;

  _TagItem({@required index, @required value, @required shouldActivate})
      : _index = index,
        _value = value,
        _shoudActivate = shouldActivate;

  void _deleteTagDialog(context, itemIndex) async {
    bool result = (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to remove this tag?', style: GoogleFonts.openSans()),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No', style: GoogleFonts.openSans()),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes', style: GoogleFonts.openSans()),
          ),
        ],
      ),
    )) ?? false;
    if (result) {
      print(itemIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Opacity(
        opacity: _shoudActivate? 1.0: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_value', style: GoogleFonts.openSans(fontSize: 17.0),),
            SizedBox(width: 16.0,),
            GestureDetector(
              onTap: _shoudActivate
              ? () {
                _deleteTagDialog(context, _index);
              }: null,
              child: Icon(FontAwesomeIcons.trashAlt, color: Colors.redAccent,),
            )
          ],
        ),
      )
    );
  }
}

class _FormThirdPage extends StatefulWidget {
  final PageController _pageFormController;
  
  _FormThirdPage({@required PageController pageFormController})
      : _pageFormController= pageFormController;

  @override
  State<_FormThirdPage> createState() => _FormThirdPageState();
}

class _FormThirdPageState extends State<_FormThirdPage> {
  PageController get _pageFormController => widget._pageFormController;
  Timer _debounce;
  DateTime _selectedDate, _startTime, _endTime;

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(max(300, MediaQuery.of(context).size.width * 0.75), 800),
      alignment: Alignment(0, -0.2),
      child: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 16.0),
            children: [
              SizedBox(
                width: 200.0,
                height: 200.0,
                child: PageView(
                  onPageChanged: (index) {
                    print(index);
                  },
                  children: [
                    for (Map room in state.roomList)
                      CachedImage(url: room['picture']),
                  ],
                ),
              ),
              Text('Swipe image to change the selected room', style: GoogleFonts.openSans(fontSize: 14.0)),
              SizedBox(height: 16.0,),
              Text('Selected room: ', style: GoogleFonts.openSans(fontSize: 17.0)),
              Text('Selected date: ${DateFormat.yMMMMd().format(DateTime.now())}', style: GoogleFonts.openSans(fontSize: 17.0)),
              Text('\t- Start time: ${DateFormat.Hm().format(DateTime.now())}', style: GoogleFonts.openSans(fontSize: 17.0)),
              Text('\t- End time: ${DateFormat.Hm().format(DateTime.now())}', style: GoogleFonts.openSans(fontSize: 17.0)),
              SizedBox(height: 8.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        _selectedDate = await _getSelectedDate();
                        print(_selectedDate);
                      },
                      child: Text('Change Date', style: GoogleFonts.openSans(decoration: TextDecoration.underline)),
                    )
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        _startTime = await _getSelectedTime();
                        print(_startTime);
                      },
                      child: Text('Change S. time', style: GoogleFonts.openSans(decoration: TextDecoration.underline)),
                    )
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        _endTime = await _getSelectedTime();
                        print(_endTime);
                      },
                      child: Text('Change E. time', style: GoogleFonts.openSans(decoration: TextDecoration.underline)),
                    )
                  )
                ],
              ),
              SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      _pageFormController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Text('Prev', style: GoogleFonts.openSans()),
                  ),
                  RaisedButton(
                    onPressed: () {
                      print('submit');
                    },
                    child: Text('Submit', style: GoogleFonts.openSans()),
                  ),
                ],
              )
            ],
          ); 
        },
      ),
    );
  }

  Future<DateTime> _getSelectedDate() async {
    DateTime selectedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    ));
    return selectedDate;
  }

  Future<DateTime> _getSelectedTime() async {
    DateTime selectedTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, 0, 0, 0);
    bool isSubmitted = ((await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose wanted time.', style: GoogleFonts.openSans()),
        content: Container(
          width: 200.0,
          height: 100.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: selectedTime,
            onDateTimeChanged: (DateTime newTime) { selectedTime = newTime; },
            minuteInterval: 5,
            use24hFormat: true
          ),  
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('OK'),
          ),
        ],
      ),
    )) ?? false);
    if (isSubmitted) {
      return selectedTime;
    }
    return null;
  }
}

class CachedImage extends StatelessWidget {
  final String _url;

  CachedImage({@required url})
      : _url = url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 200.0,
      height: 200.0,
      fit: BoxFit.cover,
      imageUrl: '$_url',
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ), 
      errorWidget: (context, url, error) => Center(
        child: Icon(FontAwesomeIcons.exclamationTriangle),
      ),
    );
  }
}
