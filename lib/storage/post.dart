import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repo/auth/login.dart';
import 'package:repo/storage/Postdetail.dart';
import 'package:repo/storage/addpost.dart';
import 'package:repo/utils/utils.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});
  final ref = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddPostScreen());
        },
        child: Icon(Icons.add_outlined),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()async {
              await FirebaseAuth.instance.signOut();
              Get.to(LoginScreen());
            },
            icon: Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
        title: Text(
          'Post',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, snapshot) {
                Map<dynamic, dynamic> mp =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                
                list = mp.values.toList();
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: mp.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.to(
                            Postdetail(
                              title: list[index]['name'],
                            ),
                          );
                        },
                        title: Text(
                          list[index]['data'],
                        ),
                        subtitle: Text(list[index]['id']),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // Expanded(
          //   child: FirebaseAnimatedList(
          //     query: ref,
          //     itemBuilder: (
          //       context,
          //       snapshot,
          //       animation,
          //       index,
          //     ) {
          //       return ListTile(
          //         isThreeLine: true,
          //         onTap: () {
          //           Get.to(Postdetail(
          //             title: snapshot.child('name').value.toString(),
          //           ));
          //         },
          //         leading: Icon(Icons.account_circle_outlined),
          //         title: Text(snapshot.child('data').value.toString()),
          //         subtitle: Text(snapshot.child('id').value.toString()),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  
  }
}
