import 'package:ems/Admin/dashboard.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:ems/Signup/role.dart';
import 'package:ems/Signup/user_login.dart';
import 'package:ems/Signup/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        builder: EasyLoading.init(),
       initialRoute: '/role',
        routes: {
          '/role': (context) => Role(),
          '/userLogin': (context) => UserLogin(),
          '/userRegister': (context) => UserRegister(),
          '/dashboard': (context) => Dashboard(),
        },
      ),
    ),
  );
}
