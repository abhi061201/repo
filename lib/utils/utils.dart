import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:repo/Screens/HomeScreen.dart';
import 'package:repo/Screens/dashboard.dart';
import 'package:repo/auth/login.dart';
import 'package:repo/auth/phone_number_auth.dart';
import 'package:repo/storage/post.dart';

bool islogin = false;
var loading = false.obs;

class Utils {
  FirebaseAuth auth = FirebaseAuth.instance;
  Reference ref = FirebaseStorage.instance.ref();
  Fluttertoast toastmsg = Fluttertoast();
  final databaseref = FirebaseDatabase.instance.ref('MyDatabase');
  void setLogin() {
    islogin = false;
  }

  Login(String email, String password) {
    loading = false.obs;

    var user = auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      islogin = true;
      Fluttertoast.showToast(
        msg: 'User Logged In Successfully',
      );
      Get.to(HomeScreen());
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

  Future<void> addcomment(
      String id, List<String> previous_list, String comment) async {
    
    previous_list.add(comment);
    databaseref
        .child(id)
        .update({'commentList': previous_list})
        .then((value) =>
            Fluttertoast.showToast(msg: 'comment Added successfully'))
        .onError(
          (error, stackTrace) => Fluttertoast.showToast(
            msg: 'Error Occurred',
          ),
        );
  }

  


  Future<void> showComments(String id) async {}
}
