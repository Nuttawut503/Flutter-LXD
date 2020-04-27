import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  child: _SectionEventAdd(),
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
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
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
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text('Loading', style: GoogleFonts.openSans()),
                ),
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  @override
  void initState() { 
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _tagController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(24.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    icon: Icon(FontAwesomeIcons.mailBulk),
                    labelText: 'Title',
                  ),
                  maxLength: 39,
                  autocorrect: false,
                ),
                SizedBox(height: 4.0,),
                TextFormField(
                  controller: _detailController,
                  decoration: InputDecoration(
                    icon: Icon(FontAwesomeIcons.mailBulk),
                    labelText: 'Detail',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  autocorrect: false,
                ),
                SizedBox(height: 4.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _tagController,
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.mailBulk),
                          labelText: 'Tags (up to 5)',
                        ),
                        autocorrect: false,
                        maxLength: 20,
                      ),
                    ),
                    SizedBox(width: 16.0,),
                    RaisedButton(
                      onPressed: (state.tags.length < 5)
                        ? () {
                          BlocProvider.of<BookingBloc>(context).add(TagAdded(tagName: _tagController.text.trim().replaceAll(RegExp(' +'), ' ')));
                        }
                        : null,
                      color: Colors.blue,
                      child: Text('ADD', style: GoogleFonts.openSans(color: Colors.white)),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < state.tags.length; ++i)
                      _TagManages(index: i, value: state.tags[i])
                  ],
                )
              ]
            )
          ),
        );
      }
    );
  }
}

class _TagManages extends StatelessWidget {
  final int _index;
  final String _value;

  _TagManages({@required index, @required value})
      : _index = index,
        _value = value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$_value'),
        SizedBox(width: 8.0,),
        GestureDetector(
          onTap: () {
            print(_index);
          },
          child: Icon(FontAwesomeIcons.trashAlt, color: Colors.red,),
        )
      ],
    );
  }
}
