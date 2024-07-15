import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/Admin/dashboard.dart';
import 'package:ems/Employee/homepage.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class Password extends StatelessWidget {
  Password({super.key});

  final passKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Set New Password', style: TextStyle(color: Colors.white)),
        backgroundColor: model.isAdmin ? Colors.redAccent : Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FormBuilder(
          key: passKey,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.password),
                  SizedBox(width: 10),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'password',
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                        FormBuilderValidators.hasUppercaseChars(atLeast: 1),
                        FormBuilderValidators.hasNumericChars(atLeast: 1),
                        FormBuilderValidators.hasSpecialChars(atLeast: 1),
                      ]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.password_sharp),
                  SizedBox(width: 10),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'repassword',
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Re-Password'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                        FormBuilderValidators.hasUppercaseChars(atLeast: 1),
                        FormBuilderValidators.hasNumericChars(atLeast: 1),
                        FormBuilderValidators.hasSpecialChars(atLeast: 1),
                      ]),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: 'loading...');
                        if (passKey.currentState!.saveAndValidate()) {
                          if (passKey.currentState!.fields['password']!.value ==
                              passKey.currentState!.fields['repassword']!.value) {

 CollectionReference users =
                                FirebaseFirestore.instance.collection('users');
                            QuerySnapshot querySnapshot =
                                await users.where('phnum', isEqualTo: model.getPhoneNumber).get();
                    
                            if (querySnapshot.docs.isNotEmpty) {
                              DocumentSnapshot userDoc = querySnapshot.docs.first;
                              await userDoc.reference.update({
                                'password':
                                    passKey.currentState!.fields['password']!.value
                              });
                              EasyLoading.dismiss();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(builder: (context) => model.isAdmin?Dashboard():UserHome()),
                                  (route) => false);
                            } else {
                              EasyLoading.dismiss();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('User with ID ${model.UID} does not exist.'),
                                ),
                              );
                            }
                                }
                           
                          } else {
                            EasyLoading.dismiss();  
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Password does not match')));
                          }
                        
                      },
                      child: const Text('Submit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: model.isAdmin ? Colors.redAccent : Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
