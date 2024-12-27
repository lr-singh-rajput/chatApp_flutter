import 'package:chatapp/Controller/ChatController.dart';
import 'package:chatapp/Controller/GroupController.dart';
import 'package:chatapp/Controller/ImagePicker.dart';
import 'package:chatapp/Model/GroupModel.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Config/Images.dart';
import '../../../Widget/ImagePickerBottomSheet.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    ImagePickerController imagePickerController =Get.put(ImagePickerController());
    TextEditingController messageController = TextEditingController();

    RxString message = "".obs;
    RxString selectedImagePath = "".obs;
    //RxString imagePath = "".obs;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Container(
              height: 35,
              width: 30,
              padding: EdgeInsets.all(3),
              child: SvgPicture.asset(
                AssetsImage.chatEmoji,
                width: 20,
              )),

          SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
                onChanged: (value){
                  message.value=value;
                },
                controller: messageController,
                decoration:
                InputDecoration(filled: false, hintText: "Type massage..."),
              )),
          SizedBox(
            width: 15,
          ),
          Obx(()=> groupController.selectedImagePath.value== ""
              ? InkWell(
            onTap: () async {


              ImagePickerBottomSheet(context, groupController.selectedImagePath, imagePickerController);
            },
            child: Container(
              height: 25,width: 25,
              child: SvgPicture.asset(
                AssetsImage.galleryIconSVG,
                width: 20,
                color: Colors.black,
              ),
            ),
          )
              :SizedBox(),
          ),
          SizedBox(
            width: 14,
          ),
          Obx(() => message.value != ""|| groupController.selectedImagePath.value != ""
              ? InkWell(
            onTap: () {
              groupController.sendGroupMessage(
                  messageController.text,
                  groupModel.id!,
                  "",
              );
              messageController.clear();
              message.value ="";

            },
            child: Container(
                height: 35,
                width: 30,
                padding: EdgeInsets.all(3),
                child: Container(
                  height: 25,width: 25,
                  child: groupController.isLoading.value
                      ? CircularProgressIndicator()
                      :SvgPicture.asset(
                    AssetsImage.sendSVG,
                    width: 20,
                  ),
                )),
          )
              :Container(
            height: 25,width: 25,
            child: SvgPicture.asset(
              AssetsImage.micSVG,

            ),
          )
          )
        ],
      ),
    );
  }

}
