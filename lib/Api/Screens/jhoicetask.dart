import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:repo/Api/Models/newModel.dart';
import 'package:http/http.dart' as http;
import 'package:repo/Api/Screens/jhoicePost.dart';

class jhoiceTask extends StatelessWidget {
   jhoiceTask({super.key});

  List<Data> list=[];
  Future<List<Data>> getlist()async{
    final response= await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if(response.statusCode==200)
    {

      var data = jsonDecode(response.body.toString());
      // print(data['data'][0]['id']);
      for(Map<String, dynamic> i in data['data'] )
      {
        
        list.add(Data.fromJson(i));
      }

    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jhoice Task'), automaticallyImplyLeading: false, centerTitle: true,),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getlist(),
              builder: (context, snapshot) {
              if(snapshot.hasData)
              {
                return ListView.builder(
                  
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    // return Text(list[0].email.toString());
                  return jhoicePostStructure(index: index, list: list,);
                },);
              }
              else 
              {
                return Center(child: CircularProgressIndicator(),);
              }
            },),
          )
        ],
      ),
    );
  }
}