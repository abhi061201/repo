import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repo/Screens/dashboard.dart';
import 'package:repo/auth/forgotpassword.dart';
import 'package:repo/auth/phone_number_auth.dart';
import 'package:repo/auth/signup.dart';
import 'package:repo/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;
  Utils _util = Utils();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'LoginScreen',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    hintText: 'email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return ElevatedButton(
                    onPressed: () {
                      _util.loading.value = true;

                      _util.Login(emailcontroller.text, passcontroller.text);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(),
                      child: _util.loading.value
                          ? Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                              ),
                            ),
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(SignupScreen());
                  },
                  child: Text(
                    'Did\'n have Account SignUp',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: Text(
                    'Forgot Password',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(phoneNumberLogin());
                  },
                  child: Text(
                    'Login with phone number',
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
