import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repo/utils/utils.dart';

var databaseRef = FirebaseDatabase.instance.ref('Post');

class AddPostScreen extends StatefulWidget {
  AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  TextEditingController postcontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  Widget build(BuildContext context) {
    var media= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Post,',
        ),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children:[ 
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: media.height*0.03,
            ),
            TextFormField(
              controller: titlecontroller,
              decoration: InputDecoration(
                hintText: 'Post Title\n',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: media.height*0.02,),
            TextFormField(
              controller: postcontroller,
              decoration: InputDecoration(
                hintText: 'What\'s in your mind ?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (postcontroller.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please write something');
                } else {
                  databaseRef
                      .child(DateTime.now().millisecondsSinceEpoch.toString())
                      .set({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'PostTitle': titlecontroller.toString(),
                    'data': postcontroller.text.toString(),
                    
                  }).then((value) {
                    Fluttertoast.showToast(msg: 'Post Added Successfully');
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(msg: 'Failed $error');
                  });
                }
              },
              child: Text(
                'Add Post',
              ),
            ),
          ],
        ),]
      ),
    );
  }
}
