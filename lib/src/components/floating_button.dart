import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LXD/src/components/render_gmap.dart' as render_gmap;
class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _CustomButton(
            assetImage: 'images/booking.png',
            label: 'Booking',
            onpressFunction: () => print('Booking'),
          ),
          SizedBox(height: 10.0,),
          _CustomButton(
            assetImage: 'images/search.png',
            label: 'Search',
            onpressFunction: () => print('Search'),
          ),
          SizedBox(height: 10.0,),
          _CustomButton(
            assetImage: 'images/navigate.png',
            label: 'Navigate',
            onpressFunction: () => {
              print('Navigate'),
              render_gmap.openUrl.openMap(13.6515714,100.4944994)
            },
          ),
        ],
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final String _assetImage;
  final String _label;
  final Function _onpressFunction;

  _CustomButton({Key key, @required String assetImage, @required String label, @required Function onpressFunction})
      : _assetImage = assetImage,
        _label = label,
        _onpressFunction = onpressFunction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onpressFunction();
      },
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_assetImage),
                fit: BoxFit.contain
              ),
            ),
          ),
          Text(
            '$_label',
            style: GoogleFonts.openSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      )
    );
  }
}

