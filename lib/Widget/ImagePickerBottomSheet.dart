import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../Controller/ChatController.dart';
import '../Controller/ImagePicker.dart';

Future<dynamic> ImagePickerBottomSheet(
    BuildContext context,
    RxString imagePath,
    ImagePickerController imagePickerController
    ) {
  return Get.bottomSheet(
      Container(
        height:150 ,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap:() async{
                imagePath.value =
                await imagePickerController.pickImage(ImageSource.camera);
                Get.back();

              },
              child: Container(
                height: 70,width: 70,
                child: Icon(Icons.camera_alt,size: 25,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.background
                ),
              ),
            ),
            InkWell(
              onTap:() async {
                imagePath.value =
                await imagePickerController.pickImage(ImageSource.gallery);
                Get.back();

              },
              child: Container(
                height: 70,width: 70,
                child: Icon(Icons.photo,size: 25,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.background
                ),
              ),
            ),
            InkWell(
              onTap:() {

              },
              child: Container(
                height: 70,width: 70,
                child: Icon(Icons.play_arrow,size: 25,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.background
                ),
              ),
            )
          ],
        ),
      )
  );
}
