import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class goToMap {
  static Completer<GoogleMapController> _controller = Completer();

  static return_gmap(){
    double latitude=13.6515714, longitude=100.4944994;
    return  Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude,longitude),
            zoom: 16,
          ),
          markers: {
            Marker(
                markerId: MarkerId("m1"),
                position: LatLng(latitude,longitude),
                infoWindow: InfoWindow(title: "LX", snippet: "Learning Exchange")),

          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        )
    );
  }}

class openUrl {

  openUrl._();

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