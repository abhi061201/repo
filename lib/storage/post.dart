import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repo/auth/login.dart';
import 'package:repo/storage/addpost.dart';

class PostScreen extends StatelessWidget {
   PostScreen({super.key});
  final ref= FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(AddPostScreen());
      }, child: Icon(Icons.add_outlined),),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.to(LoginScreen());
          }, icon: Icon(Icons.logout_outlined,),),
        ],
        title: Text(
          'Post',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(query: ref, itemBuilder:(context, snapshot,animation, index){
              return ListTile(
                title: Text(snapshot.child('data').value.toString()),
              );
            }),
          ),

        ],
      ),
      
    );
  }
}
