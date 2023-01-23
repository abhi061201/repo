import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:repo/auth/verifyOtpScreen.dart';
import 'package:repo/utils/utils.dart';

class phoneNumberLogin extends StatefulWidget {
  const phoneNumberLogin({super.key});

  @override
  State<phoneNumberLogin> createState() => _phoneNumberLoginState();
}

class _phoneNumberLoginState extends State<phoneNumberLogin> {
  @override
  bool loading =false;
  final phonenubercontroller = TextEditingController();
  final String countrycode= "+91";
  final otpconroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Phone Number Login Screen',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: TextFormField(
                controller: phonenubercontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0123 456 789',
                  
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading=true;
                });
                var credential = auth.verifyPhoneNumber(
                  phoneNumber: countrycode+phonenubercontroller.text,
                  verificationCompleted: (_) {},
                  verificationFailed: (e) {
                    setState(() {
                      loading=false;
                    });
                    Fluttertoast.showToast(
                      msg: e.toString(),
                    );
                  },
                  codeSent:(String verficationid, int ?token){
                    setState(() {
                      loading=false;
                    });
                    Get.to(VerifyOtpScreen(
                      verifivationId: verficationid,
                    ));
                  },

                  // code aa chuka h aur timeout ho gya h

                  codeAutoRetrievalTimeout: (e) {
                    setState(() {
                      loading=false;
                    });
                    Fluttertoast.showToast(
                      msg: e.toString(),
                    );
                  },
                );
              },
              child: Container(
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: !loading?Text(
                    'Login',
                  ):CircularProgressIndicator(
                    color: Colors.white,
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
