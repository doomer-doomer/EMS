import 'package:ems/Employee/attendance.dart';
import 'package:ems/Employee/overview.dart';
import 'package:ems/Employee/profile.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHome extends StatelessWidget {
   UserHome({super.key});

   List<Widget> _children = [
    UserOverview(),
    UserAttendance(),
    UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      body: _children.elementAt(model.getUserIndex),
       bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        unselectedItemColor: Colors.grey[600],
        unselectedLabelStyle: TextStyle(color: Colors.grey[600]),
        selectedLabelStyle: TextStyle(color: Colors.blueAccent),
        selectedItemColor: Colors.blueAccent,
        currentIndex: model.getUserIndex,
        onTap: (index) {
          model.setUserIndex(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Attendance',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
          
        ],
      ),
    );
  }
}