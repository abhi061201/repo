import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:repo/Api/Models/postmodel.dart';
import 'package:http/http.dart' as http;

import 'MyPostStructure.dart';

class ApiDataScreen extends StatelessWidget {
   ApiDataScreen({super.key});

  List<PostModel> postList= [];
  Future<List<PostModel>> getPostList()async{
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if(response.statusCode==200)
    {
      var data= jsonDecode(response.body.toString());
      for(Map<String,dynamic> i in data)postList.add(PostModel.fromJson(i));
    }
    return postList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ApiDataScreen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostList(),
              builder: (context, snapshot) {
                
              return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                
                if(snapshot.hasData)
                {
                  return MyPostStructure(list: postList, index:  index,);
                }
                else return Center(child: CircularProgressIndicator(),);
              },);
            },),
          )
        ],
      ),
    );
  }
}
