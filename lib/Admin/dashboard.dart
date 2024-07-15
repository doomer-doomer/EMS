import 'package:ems/Admin/employee.dart';
import 'package:ems/Admin/overview.dart';
import 'package:ems/Admin/profile.dart';
import 'package:ems/Admin/schedule.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  List<Widget> _children = [
    AdminOverview(),
    AdminEmployees(),
    AdminProfile()
  ];

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[model.getAdminIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        unselectedLabelStyle: TextStyle(color: Colors.grey[600]),
        selectedLabelStyle: TextStyle(color: Colors.redAccent),
        selectedItemColor: Colors.redAccent,
        currentIndex: model.getAdminIndex,
        onTap: (index) {
          model.setAdminIndex(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Employees',
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