import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:repo/Api/Models/newModel.dart';
import 'package:repo/Api/Screens/UserProfile.dart';
import 'package:repo/Api/Screens/JhoiceUpdatePostScreen.dart';

class jhoicePostStructure extends StatelessWidget {
  int index;
  List<Data> list = [];
  jhoicePostStructure({super.key, required this.index, required this.list});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: (){
            Get.to(UserProfile(list: list,index: index,));
          },
          child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(list[index].avatar.toString()),
                ),
              ),
              title: Text(list[index].firstName.toString()),
              // subtitle: Text(list[index].),
              trailing: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.edit_outlined),
                        onTap: () {
                          Get.back();
                          Get.to(JhoiceUpdatePostScreen());
                          // updatepost('', '', list[index]['id']);
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
                          // Get.to(imagePicker());
                        },
                        title: Text('Add Profile Image'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: ListTile(
                        leading: Icon(Icons.delete_outline_outlined),
                        onTap: () {
                          Get.back();
                          // deletePost(list[index]['id']);
                        },
                        title: Text('Delete'),
                      ),
                    ),
                  ];
                },
              )),
        ),
        Container(
          height: media.height * 0.37,
          width: media.width,
          decoration: BoxDecoration(
            color: Colors.grey[400],
          ),
          child: Card(
            child: Center(child: Text(list[index].email.toString())),
          ),
        ),
        // Row(children: [
        //   IconButton(
        //     icon: Icon(Icons.favorite),
        //     color: list[index]['likeCount'] == 0 ? Colors.black : Colors.red,
        //     onPressed: () {
        //       updateLike(list[index]['likeCount'], list[index]['id']);
        //     },
        //   ),
        //   Text(list[index]['likeCount'].toString()),
        //   IconButton(
        //       onPressed: () {
        //         showDialog(
        //             context: context,
        //             builder: ((context) {
        //               return AlertDialog(
        //                 content: TextFormField(
        //                   controller: commentcontroller,
        //                   decoration: InputDecoration(
        //                     hintText: 'Add Comment',
        //                   ),
        //                 ),
        //                 actions: [
        //                   TextButton(
        //                       onPressed: () {
        //                         Get.back();
        //                         _utils.addcomment(
        //                             list[index]['id'],
        //                             list[index]['commentList'],
        //                             commentcontroller.text.toString());
        //                         // _utils.showComments(list[index]['id']);
        //                       },
        //                       child: Text('Add'))
        //                 ],
        //               );
        //             }));
        //       },
        //       icon: Icon(Icons.comment_outlined)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.send_outlined))
        // ]),

        SizedBox(
          height: media.height * 0.03,
        )
      ],
    );
  }
}
