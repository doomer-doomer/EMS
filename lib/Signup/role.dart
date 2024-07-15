import 'package:ems/Admin/dashboard.dart';
import 'package:ems/Employee/homepage.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:ems/Signup/user_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {

  

  @override
  void initState() {
    super.initState();
    checkLogin(context);
  }

  Future<void> checkLogin(BuildContext context)async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? id = sharedPreferences.getString('id');
    final bool? isAdmin = sharedPreferences.getBool('isAdmin');
    UserData model = context.read<UserData>();

    if (id != null && id.isNotEmpty) {
      model.setIsAdmin(isAdmin! == true ? true : false);
      model.setUID(id);
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => isAdmin==true ? Dashboard() : UserHome()), (route) => false);
  }
  }
  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Role Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Pick a role to continue'),
            ElevatedButton(
              onPressed: () {
                model.setIsAdmin(true);
                Navigator.push(context, CupertinoPageRoute(builder: (context) => UserLogin()));
              },
              child: Text('Admin'),
            ),
            ElevatedButton(
              onPressed: () {
                model.setIsAdmin(false);
                Navigator.push(context, CupertinoPageRoute(builder: (context) => UserLogin()));
              },
              child: Text('Employee'),
            ),
            
          ],
        ),
      ),
    );
  }
}