import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repo/Api/Screens/jhoicetask.dart';
import 'package:repo/Api/api_auth/loginScreen.dart';
import 'package:repo/Screens/dashboard.dart';
import 'package:repo/auth/login.dart';
import 'package:repo/auth/signup.dart';
import 'package:repo/utils/utils.dart';
import 'storage/post.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    
    home: ApiLogin(),
    // home:LoginScreen(),
    // home: jhoiceTask(),
    );
  }
}