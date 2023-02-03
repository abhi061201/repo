import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
class addPostMydatabaseScreen extends StatelessWidget {
  
  final databaseref= FirebaseDatabase.instance.ref('MyDatabase');
  bool isLiked=false;
  TextEditingController postcontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  Widget build(BuildContext context) {
    var media= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Post MyDatabase',
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
                  List <String>commentsList=[];
                  String id= DateTime.now().millisecondsSinceEpoch.toString();
                  databaseref
                      .child(id)
                      .set({
                    'id': id,
                    'PostTitle': titlecontroller.text.toString(),
                    'data': postcontroller.text.toString(),
                    'likeCount':0.toInt(),
                    'commentList':commentsList.toList(),
                    // 'islike':isLiked,
                    
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