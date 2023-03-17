import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart';

class ApiLogin extends StatelessWidget {
  const ApiLogin({super.key});
  

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcotroller = TextEditingController();
    TextEditingController passwordcotroller = TextEditingController();
    void login(String email, String password) async {
    try {
      var response = await post(
        Uri.parse(
          'https://reqres.in/api/register',
        ),
        body: {
          'email':email,
          'password':password,
        }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data.toString());
        print('successfull');
      } else {
        print('Registration failed');
      }
    } catch (e) {
      // print(e.toString());
      print('failed');
    }
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Api Login',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcotroller,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: passwordcotroller,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                // debugPrint('tappped');
                login(emailcotroller.text.toString(),
                    passwordcotroller.text.toString());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                height: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
