import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:repo/Screens/dashboard.dart';
import 'package:repo/auth/login.dart';

class Utils {
  FirebaseAuth auth = FirebaseAuth.instance;
  Reference ref = FirebaseStorage.instance.ref();
  Fluttertoast toastmsg = Fluttertoast();
  Login(String email, String password) {
    var user = auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      Fluttertoast.showToast(
        msg: 'User Logged In Successfully',
      );
      Get.to(Dashboard());
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
        msg: 'User Logged In failed',
      );
    });
  }

  Signup(String username, String email, String password) {
    var user = auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      Fluttertoast.showToast(msg: 'User created Successfully');
      Get.to(LoginScreen());
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: 'User creation failed due to $error');
    });
  }
}
