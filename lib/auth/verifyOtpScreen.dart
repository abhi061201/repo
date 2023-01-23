import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:repo/storage/post.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.verifivationId});
  final String verifivationId;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  bool loading=false;
  FirebaseAuth auth= FirebaseAuth.instance;
  final otpcontroller= TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'verify Screen',
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
                controller: otpcontroller,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: '123456',
                  
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: ()async {
                setState(() {
                  loading=true;
                });
                var credential = PhoneAuthProvider.credential(
                  verificationId: widget.verifivationId, 
                  smsCode: otpcontroller.text
                  );

                  try{
                    
                    await auth.signInWithCredential(credential);
                    Get.to(PostScreen());
                    setState(() {
                      loading=false;
                    });
                  }
                  catch(e)
                  {
                    
                    Fluttertoast.showToast(msg: 'Login faled');
                    setState(() {
                      loading=false;
                    });
                  }
              },
              child: Container(
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: !loading?Text(
                    'verify',
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
