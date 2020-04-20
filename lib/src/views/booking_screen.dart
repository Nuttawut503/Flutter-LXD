import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('placeholder'),),
      body: SafeArea(
        child: Text('hello'),
      ),
    );
  }
}
