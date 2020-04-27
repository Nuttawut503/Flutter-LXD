import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please wait a second...',
                style: GoogleFonts.openSans(color: Colors.white,),
              ),
              Text(
                'We\'re checking your authentication',
                style: GoogleFonts.openSans(color: Colors.white,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
