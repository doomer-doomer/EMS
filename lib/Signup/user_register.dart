import 'package:ems/Admin/dashboard.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:ems/Signup/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRegister extends StatelessWidget {
  UserRegister({super.key});

  final _signupUserFormKey = GlobalKey<FormBuilderState>();
  UserData model = UserData();

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            model.getIsAdmin ? Colors.redAccent : Colors.blueAccent,
      ),
      body: FormBuilder(
        key: _signupUserFormKey,
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
                name: 'Name',
                decoration: const InputDecoration(labelText: 'Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.alphabetical()
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
              ),
              child: FormBuilderTextField(
                name: 'UniqueID',
                decoration: const InputDecoration(labelText: 'Unique ID'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
              ),
              child: FormBuilderTextField(
                name: 'PhoneNumber',
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer()
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Already have an account?',
                        style: TextStyle(
                            color: model.getIsAdmin
                                ? Colors.redAccent
                                : Colors.blueAccent)),
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
                      backgroundColor: model.getIsAdmin
                          ? Colors.redAccent
                          : Colors.blueAccent,
                    ),
                    onPressed: () async {
                      EasyLoading.show(status: 'loading...');
                      if (_signupUserFormKey.currentState!.saveAndValidate()) {
                        model.setPhoneNumber(_signupUserFormKey
                            .currentState!.value['PhoneNumber']);
                        model.setUID(
                            _signupUserFormKey.currentState!.value['UniqueID']);
                        model.setEpname(
                            _signupUserFormKey.currentState!.value['Name']);
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber:
                              "+91${_signupUserFormKey.currentState!.value['PhoneNumber']}",
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
                            content: Text(_signupUserFormKey.currentState!.value
                                .toString()),
                          ),
                        );
                      }
                      EasyLoading.dismiss();
                    },
                    child: const Text('Sign up',
                        style: TextStyle(color: Colors.white)),
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
