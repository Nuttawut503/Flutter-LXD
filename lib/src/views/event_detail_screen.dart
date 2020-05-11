import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LXD/src/authentication/authentication_bloc.dart';
import 'package:LXD/src/controllers/detail/bloc.dart';
import 'package:badges/badges.dart';

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
            child: Stack(
              children: [
                _BackgroundEventDetail(),
                _HeaderEventDetail(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 0.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: MediaQuery.of(context).size.height * 0.25,
                          spreadRadius: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ]
                    )
                  )
                ),
                Positioned(
                  bottom: 0,
                  child: _ContentEventDetail(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderEventDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) => Container(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Material(    
              color: Colors.white.withOpacity(0.3),
              shape: CircleBorder(),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                splashColor: Colors.black.withOpacity(0.3),
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(FontAwesomeIcons.arrowLeft, size: 19.0),
                ),
              ),
            ),
            Spacer(),
            Text(
              state.isLoading? 'Event': '${state.detailInfo['title']}\'s info',
              style: GoogleFonts.openSans(fontSize: 19.0, color: Colors.transparent)
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
                    child: Icon(FontAwesomeIcons.arrowLeft, size: 19.0),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class _BackgroundEventDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 229, 255, 1.0),
      ),
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) => (state.isLoading)
        ? Center(
          child: CircularProgressIndicator(),
        )
        : CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: '${state.detailInfo['room']['picture']}',
          progressIndicatorBuilder: (context, url, downloadProgress) => Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Center(
              child: CircularProgressIndicator(value: downloadProgress.progress),
            ),
          ), 
          errorWidget: (context, url, error) => Center(
            child: Center(
              child: Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.red),
            ),
          ),
        )
      ),
    );
  }
}

class _ContentEventDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) => (state.isLoading)
        ? Container()
        : Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 12.0,
                children: [
                  for (String tag in state.detailInfo['tags'])
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Badge(
                        badgeColor: Colors.orange.shade700,
                        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                        shape: BadgeShape.square,
                        borderRadius: 20,
                        toAnimate: false,
                        badgeContent: Text('$tag', style: GoogleFonts.openSans(color: Colors.white)),
                      ),
                    )
                ],
              ),
              SizedBox(height: 12.0,),
              Text('${state.detailInfo['title']}', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w800, color: Colors.white, shadows: [Shadow(blurRadius: 5.0)])),
              SizedBox(height: 12.0),
              Text('${state.detailInfo['detail']}', style: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.white, shadows: [Shadow(blurRadius: 5.0)])),
              SizedBox(height: 24.0),
              Text('${state.detailInfo['schedule']['date']} (${state.detailInfo['schedule']['start_time']} - ${state.detailInfo['schedule']['end_time']})', style: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.white, shadows: [Shadow(blurRadius: 5.0)])),
              SizedBox(height: 4.0),
              Text('At ${state.detailInfo['room']['name']}', style: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.white, shadows: [Shadow(blurRadius: 5.0)])),
              SizedBox(height: 16.0),
              Text('Sponsored by ${state.detailInfo['reserver_name']}', style: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.white, shadows: [Shadow(blurRadius: 5.0)])),
              SizedBox(height: 32.0,),
            ],
          )
        )
      )
    );
  }
}
