import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Postdetail extends StatelessWidget {
  String title;
   Postdetail({super.key,required this.title});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PostScreen',
        ),
      ),
      body: Center(
        child: Text(
          'Still working',
          style: TextStyle(
            fontSize: 40,
          )
        ),
      ),
    );
  }
}
