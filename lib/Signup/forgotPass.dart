import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:ems/Signup/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class FPassword extends StatelessWidget {
   FPassword({super.key});

  final fpassKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
     
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: model.getIsAdmin ? Colors.redAccent : Colors.blueAccent,
        title: Text('Forgot Password', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FormBuilder(
          key: fpassKey,
          child: Column(
            children: [
              Text('Enter your phone number to reset your password'),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,

               children: [
                Icon(Icons.phone),
                SizedBox(width: 10),
                 Expanded(
                   child: FormBuilderTextField(
                      name: 'phone',
                      
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.minLength(10),
                        FormBuilderValidators.maxLength(10),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: model.getIsAdmin ? Colors.redAccent : Colors.blueAccent,
                      ),
                      onPressed: () async{
                        if (fpassKey.currentState!.saveAndValidate()) {
                          // Navigator.push(context, CupertinoPageRoute(builder: (context) => OTP(id: ,)));
                          EasyLoading.show(status: 'loading...');
                            if (fpassKey.currentState!.saveAndValidate()) {
                              model.setPhoneNumber(fpassKey
                                  .currentState!.value['phone']);
                                  CollectionReference users = FirebaseFirestore.instance.collection('users');
                              QuerySnapshot querySnapshot = await users.where('phnum', isEqualTo: model.getPhoneNumber).get();
                              if (querySnapshot.docs.isNotEmpty) {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber:
                                    "+91${fpassKey.currentState!.value['phone']}",
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed: (FirebaseAuthException e) {},
                                codeSent: (String verificationId, int? resendToken) {
                                  EasyLoading.dismiss();
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (build) =>
                                              OTP(id: verificationId)));
                                },
                                codeAutoRetrievalTimeout: (String verificationId) {},
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(fpassKey.currentState!.value
                                      .toString()),
                                ),
                              );
                              }
                              
                            }
                            EasyLoading.dismiss();
                        }
                      },
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
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