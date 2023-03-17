import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:repo/main.dart';

class UserProfile extends StatelessWidget {
  List list= [];
  int index;
   UserProfile({super.key , required this.list, required this.index});

  @override
  Widget build(BuildContext context) {
    var media= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('User Profile Page'),),
      body: (
        Column(
          
          children: [

            Container(
              height: media.height*0.4,
              width: media.height*0.7,
              color: Colors.amber[700],
              child: CircleAvatar(backgroundImage: NetworkImage(list[index].avatar.toString()),),

            ),

            SizedBox(height: media.height*0.05,),
            Container(
              height: media.height*0.2,
              width: media.height*0.7,
              child: Card(
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('first Name: '+list[index].firstName.toString()),
                  Divider(color: Colors.black,),
                  Text('Last Name'+list[index].lastName.toString()),
                  Divider(color:Colors.black),
                  Text('email:'+list[index].email.toString()),
                ]),
              ),
            )
          ],
        )
      ),
    );
  }
}