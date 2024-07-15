import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/Admin/dashboard.dart';
import 'package:ems/Employee/homepage.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:ems/Signup/forgotPass.dart';
import 'package:ems/Signup/user_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});

  final _loginUserFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Login', 
        
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: model.getIsAdmin?Colors.redAccent: Colors.blueAccent,
      ),
      body: FormBuilder(
        key: _loginUserFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
              ),
              child: FormBuilderTextField(
                name: 'Unique ID',
                decoration: const InputDecoration(labelText: 'Unique ID'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
              ),
              child: FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                  FormBuilderValidators.hasUppercaseChars(atLeast: 1),
                  FormBuilderValidators.hasNumericChars(atLeast: 1),
                  FormBuilderValidators.hasSpecialChars(atLeast: 1),
                ]),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      model.setFPassword(true);
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => FPassword()));
                    },
                    child: Text('Forgot Password?', style: TextStyle(color: model.getIsAdmin?Colors.redAccent: Colors.blueAccent)),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => UserRegister()));
                    },
                    child: Text('Sign Up', style: TextStyle(color: model.getIsAdmin?Colors.redAccent: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
            
            Spacer(),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: model.getIsAdmin?Colors.redAccent: Colors.blueAccent,
                    ),
                    onPressed: () async{
                      EasyLoading.show(status: 'loading...');
                      model.setFPassword(false);
                      if (_loginUserFormKey.currentState!.saveAndValidate()) {
                         model.setEpname(_loginUserFormKey.currentState!.value['Unique ID']);
                         
                      
                            CollectionReference users = FirebaseFirestore.instance.collection('users');
                             QuerySnapshot qs = await users
                              .where('id', isEqualTo: _loginUserFormKey.currentState!.value['Unique ID'])
                              .where('isAdmin',isEqualTo: model.getIsAdmin)
                              .limit(1)
                              .get();
if (qs.docs.isNotEmpty) {
                          

                            QuerySnapshot pass = await users.where('password',isEqualTo: _loginUserFormKey.currentState!.value['password']).limit(1).get();
                            if(pass.docs.isNotEmpty){
                              EasyLoading.dismiss();
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('id', _loginUserFormKey.currentState!.value['Unique ID']);
                              await prefs.setBool('isAdmin', model.getIsAdmin);
                              Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) =>model.isAdmin? Dashboard(): UserHome()), (route) => false);
                            }else{
                              EasyLoading.dismiss();
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid Password'),
                              ),
                            );              
                            
                            }
}              

                      //Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => Dashboard()), (route) => false);
EasyLoading.dismiss();
                         
                      }
                     
                      
                     
                    },
                    child: const Text('Login', style: TextStyle(color: Colors.white)),
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
