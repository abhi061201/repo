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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Post,',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: postcontroller,
            decoration: InputDecoration(
              hintText: 'What\'s in your mind ? ',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              databaseRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'name': 'Ram',
                    'data': postcontroller.text.toString()
                  })
                  .then((value) {
                    Fluttertoast.showToast(msg: 'Post Added Successfully');
                  })
                  .onError((error, stackTrace) {
                    Fluttertoast.showToast(msg: 'Failed $error');
                  });
            },
            child: Text(
              'Add Post',
            ),
          ),
        ],
      ),
    );
  }
}
