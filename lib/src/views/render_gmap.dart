import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoToMap extends StatelessWidget {
  static Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context){
    double latitude=13.6515714, longitude=100.4944994;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('LearningExchange@KMUTT'),),
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude,longitude),
            zoom: 16,
          ),
          markers: {
            Marker(
              markerId: MarkerId("m1"),
              position: LatLng(latitude,longitude),
              infoWindow: InfoWindow(title: "LX", snippet: "Learning Exchange")
            ),
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        )
      )
    );
  }
}

class OpenUrl {

  OpenUrl._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      print("open map success");
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
