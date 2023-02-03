import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:repo/Screens/AddPostMydatabase.dart';
import 'package:repo/Screens/image_picker.dart';
import 'package:repo/storage/addpost.dart';
import 'package:repo/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  RxBool like = false.obs;

  final ref = FirebaseDatabase.instance.ref('MyDatabase');

  TextEditingController newtitlecontroller = TextEditingController();
  TextEditingController newdatacontroller = TextEditingController();
  TextEditingController commentcontroller = TextEditingController();

  Future<void> updatePostData(String postname, String data, String id) async {
    final ref = FirebaseDatabase.instance.ref('MyDatabase');
    ref
        .child(id)
        .update({
          'PostTitle': postname,
          'data': data,
        })
        .then(
          (value) => Fluttertoast.showToast(
            msg: 'Post Updated',
          ),
        )
        .onError(
          (error, stackTrace) => Fluttertoast.showToast(
            msg: error.toString(),
          ),
        );
  }

  Future<void> deletePost(String id) async {
    ref.child(id).remove().then(
          (value) => Fluttertoast.showToast(msg: 'Post Deleted').onError(
            (error, stackTrace) => Fluttertoast.showToast(
              msg: 'Error Occurred',
            ),
          ),
        );
  }

  Future<void> updateLike(int previous_like, String id) async {
    ref.child(id).update({'likeCount': previous_like + 1});
  }

  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    void updatepost(String postitle, String data, String id) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: media.height * 0.2,
                child: Column(
                  children: [
                    TextFormField(
                      controller: newtitlecontroller,
                      decoration: InputDecoration(
                        hintText: 'Update post Title',
                      ),
                    ),
                    TextFormField(
                      controller: newdatacontroller,
                      decoration: InputDecoration(
                        hintText: 'Update post Data',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Get.back();
                      updatePostData(newtitlecontroller.text.toString(),
                          newdatacontroller.text.toString(), id).then((value){
                            newdatacontroller.text="";
                            newtitlecontroller.text="";
                          });
                    },
                    child: Text('Update')),
              ],
            );
          });
    }

    Utils _utils = new Utils();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(addPostMydatabaseScreen());
        },
        child: Icon(Icons.add_outlined),
      ),
      appBar: AppBar(
        title: Text('Home Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic> mp =
                      snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> list = mp.values.toList();

                  return ListView.builder(
                    itemCount: mp.length,
                    itemBuilder: (context, index) {
                      // like.value = list[index]['islike'];
                      return Column(
                        children: [
                          ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.person),
                              ),
                              title: Text(list[index]['PostTitle']),
                              subtitle: Text('Agra uttar pradesh'),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        leading: Icon(Icons.edit_outlined),
                                        onTap: () {
                                          Get.back();
                                          updatepost('', '', list[index]['id']);
                                        },
                                        title: Text('Edit'),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        leading: Icon(Icons.person_add),
                                        onTap: () {
                                          Get.back();
                                          // going to take image.
                                          Get.to(imagePicker());
                                        },
                                        title: Text('Add Profile Image'),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 3,
                                      child: ListTile(
                                        leading:
                                            Icon(Icons.delete_outline_outlined),
                                        onTap: () {
                                          Get.back();
                                          deletePost(list[index]['id']);
                                        },
                                        title: Text('Delete'),
                                      ),
                                    ),
                                  ];
                                },
                              )),
                          Container(
                            height: media.height * 0.37,
                            width: media.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                            ),
                            child: Card(
                              child: Center(child: Text(list[index]['data'])),
                            ),
                          ),
                          Row(children: [
                            IconButton(
                              icon: Icon(Icons.favorite),
                              color: list[index]['likeCount'] == 0
                                  ? Colors.black
                                  : Colors.red,
                              onPressed: () {
                                updateLike(list[index]['likeCount'],
                                    list[index]['id']);
                              },
                            ),
                            Text(list[index]['likeCount'].toString()),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          content: TextFormField(
                                            controller: commentcontroller,
                                            decoration: InputDecoration(
                                              hintText: 'Add Comment',
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  _utils.addcomment(
                                                      list[index]['id'],
                                                      list[index]
                                                          ['commentList'],
                                                      commentcontroller.text
                                                          .toString());
                                                  // _utils.showComments(list[index]['id']);
                                                },
                                                child: Text('Add'))
                                          ],
                                        );
                                      }));
                                },
                                icon: Icon(Icons.comment_outlined)),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.send_outlined))
                          ]),
                          SizedBox(
                            height: media.height * 0.01,
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
