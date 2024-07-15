import 'package:ems/Provider/UserData.dart';
import 'package:ems/Signup/role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile", style: TextStyle(color: Colors.blueAccent)),
            Icon(Icons.edit, ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 70, color: Colors.white,),
            ),
            SizedBox(height: 20), 
            Text(model.getEpname, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
            Text(model.getPhoneNumber, style: TextStyle(fontSize: 16, color: Colors.grey)),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ),
                    onPressed: () async{
                       final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => Role()), (route) => false);
                    },
                    child: Text('logout', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}