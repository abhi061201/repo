import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class imagePicker extends StatefulWidget {
  imagePicker({super.key});

  @override
  State<imagePicker> createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  File? imageFile;

  final imagepicker=ImagePicker();
  
  Future getGalleryImage()async{
    final image= await imagepicker.pickImage(source:ImageSource.gallery, imageQuality:  80);
    setState(() {
      if(image!=null){
      imageFile= File(image.path);
    }
    else {
      Fluttertoast.showToast(msg: 'Cant pick image');
    }

    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picking Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                  getGalleryImage();
              },
              child: Container(
                  color: Colors.grey,
                  height: media.height * 0.4,
                  width: media.width * 0.6,
                  child:imageFile!=null?Image.file(imageFile!.absolute): Icon(Icons.image)),
            ),
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Upload'))
        ],
      ),
    );
  }
}
