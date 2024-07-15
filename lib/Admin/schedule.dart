import 'package:flutter/material.dart';

class AdminSchedule extends StatelessWidget {
  const AdminSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Schedule'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Welcome to Schedule'),
      ),
    );
  }
}