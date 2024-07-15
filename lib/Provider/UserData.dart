import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData extends ChangeNotifier{
  static String epname='';
  static String epnum='';
  int adminIndex=0;
  int userIndex=0;
  bool isAdmin=false;
  String verificationId='';
  String phoneNumber='';
  String UID = '';
  bool fpassword=false;

  String get getEpname=>epname;
  int get getAdminIndex=>adminIndex;
  int get getUserIndex=>userIndex;
  bool get getIsAdmin=>isAdmin;
  String get getVerificationId=>verificationId;
  String get getPhoneNumber=>phoneNumber;
  String get getUID => UID;
  bool get getFPassword=>fpassword;

  void setEpname(String name){
    epname=name;
    notifyListeners();
  }  

  void setAdminIndex(int index){
    adminIndex=index;
    notifyListeners();
  }

  void setUserIndex(int index){
    userIndex=index;
    notifyListeners();
  }

  void setIsAdmin(bool value){
    isAdmin=value;
    notifyListeners();
  }

  void setVerificationId(String id){
    verificationId=id;
    notifyListeners();
  }

  void setDetails(String number, String id, String name){
    phoneNumber=number.toString();
    UID=id.toString();
    epname=name;
    notifyListeners();
  }

  void setPhoneNumber(String number){
    phoneNumber=number;
    notifyListeners();
  }

  void setUID(String id){
    UID=id;
    notifyListeners();
  }

  void setFPassword(bool value){
    fpassword=value;
    notifyListeners();
  }
}