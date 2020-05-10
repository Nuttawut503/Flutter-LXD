import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/controllers/detail/bloc.dart';

class EventDetailScreen extends StatelessWidget {
  final String _eventId;

  EventDetailScreen({@required eventId})
      : _eventId = eventId;

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
          child: BlocProvider<DetailBloc>(
            create: (context) => DetailBloc(eventId: _eventId)..add(LoadingStarted()),
            child: Column(
              children: [
                _HeaderEventDetail(),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: _ContentEventDetail(),
                  )
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class _HeaderEventDetail extends StatelessWidget {
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
          BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) => Text(
              state.isLoading? 'Event': '${state.detailInfo['title']}\'s info',
              style: GoogleFonts.openSans(fontSize: 19.0)
            ), 
          ),
          Spacer(),
          Opacity(
            opacity: 0,
            child: Material(
              child: InkWell(
                onTap: null,
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(FontAwesomeIcons.arrowLeft, size: 16.0),
                ),
              )
            )
          ),
        ]
      ),
    );
  }
}

class _ContentEventDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 229, 255, 1.0),
      ),
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${state.detailInfo['title']}', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600)),
                SizedBox(height: 16.0),
                Text('Detail: ${state.detailInfo['detail']}', style: GoogleFonts.openSans(fontSize: 16.0)),
                SizedBox(height: 12.0),
                Text('Time: ${state.detailInfo['schedule']['date']} (${state.detailInfo['schedule']['start_time']} - ${state.detailInfo['schedule']['end_time']})', style: GoogleFonts.openSans(fontSize: 16.0)),
                SizedBox(height: 12.0),
                Text('Room:', style: GoogleFonts.openSans(fontSize: 16.0)),
                Text('\t- ${state.detailInfo['room_name']}', style: GoogleFonts.openSans(fontSize: 16.0)),
                SizedBox(height: 12.0),
                Text('Name of the attandant:', style: GoogleFonts.openSans(fontSize: 16.0)),
                Text('\t- ${state.detailInfo['reserver_name']}', style: GoogleFonts.openSans(fontSize: 16.0)),
                SizedBox(height: 12.0),
                Text('Related information:', style: GoogleFonts.openSans(fontSize: 16.0)),
                Text('\t- ${state.detailInfo['tags'].join(' / ')}', style: GoogleFonts.openSans(fontSize: 16.0)),
              ],
            );
          }
        },
      )
    );
  }
}
