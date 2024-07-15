import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/Admin/dashboard.dart';
import 'package:ems/Employee/homepage.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:ems/Signup/setPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class OTP extends StatefulWidget {
  String id = '';
   OTP({super.key, required this.id});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String otp = '';

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: model.getIsAdmin ? Colors.redAccent : Colors.blueAccent,
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Enter the OTP sent to your mobile number'),
            SizedBox(height: 10),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.start,
          numberOfFields: 6,
          borderColor: Color(0xFF512DA8),
          showFieldAsBox: true, 
          onCodeChanged: (String code) {
        
          },
          onSubmit: (String verificationCode) {
            setState(() {
              otp = verificationCode;
            });
          },
         
          
        
            
            ),
            TextButton(onPressed: () async{
        Navigator.pop(context); 
            }, child: Text('Resend OTP')),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: model.getIsAdmin ? Colors.redAccent : Colors.blueAccent,
                    ),
                    onPressed: () async{
                    if(otp.length != 6 || otp.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid OTP')));
                      return;
                    }
                          try{
                            EasyLoading.show(status: 'loading...');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(otp)));
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.id, smsCode: otp);
                          
                  await auth.signInWithCredential(credential);
                             
                    if(model.fpassword){
                      EasyLoading.dismiss();
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => Password()));
                    }else{
                           CollectionReference users = FirebaseFirestore.instance.collection('users');
                    await users.add({
                      'isAdmin': model.getIsAdmin,
                      'name': model.getEpname,
                      'phnum': model.getPhoneNumber,
                      'id':model.getUID
                      
                    });
                    EasyLoading.dismiss();
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => Password()));
                    }
                   
                            
                          }catch (e){
                            print(e);
                          }
                          
                  }, child: Text('Verify', style: TextStyle(color: Colors.white)),
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