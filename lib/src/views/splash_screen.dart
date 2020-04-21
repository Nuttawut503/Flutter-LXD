import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Loading...', style: GoogleFonts.openSans(fontSize: 48.0),),
        ),
      ),
    );
  }
}
