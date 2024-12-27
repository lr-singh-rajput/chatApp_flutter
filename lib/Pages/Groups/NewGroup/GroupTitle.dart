import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Config/CustomMessage.dart';
import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Config/PagePath.dart';
import 'package:chatapp/Controller/GroupController.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Pages/Home/HomePage.dart';
import 'package:chatapp/Pages/Home/Widgets/ChatTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../Controller/ImagePicker.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    Profilecontroller profilecontroller = Get.put(Profilecontroller());
    ImagePickerController imagePickerController = Get.put(
        ImagePickerController());

    RxString imagePath = "".obs;
    RxBool isEdit = false.obs;

    //TextEditingController groupName = TextEditingController();
    RxString groupName = "".obs;

    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
      ),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          backgroundColor:  groupName.isEmpty
            ? Colors.white
            : Colors.blue,
          onPressed: () {
            if(groupName.isEmpty){
              errorMessage("Please Enter Group Name ");
              Get.snackbar("Error", "Please Enter Group Name ");

            }else {
              groupController.createGroup(groupName.value, imagePath.value);
            }
          },
          // backgroundColor: Theme.of(context).colorScheme.primary,
          child: groupController.isLoading.value
              ? CircularProgressIndicator(
            color: Colors.white,
          )
              : Icon(Icons.done,
            // color: Theme.of(context).colorScheme.onBackground,
          ),
        );
      }),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [

                      Obx(() {
                        return InkWell(
                          onTap: () async {
                            imagePath.value =
                            await imagePickerController
                                .pickImage(ImageSource.gallery);


                            print("imagePath" + imagePath());
                          },
                          child: Container(
                            width: 150, height: 150,
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: imagePath.value == ""
                                ? Icon(Icons.group, size: 45,)
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(File(imagePath.value,),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),


                      // Obx(
                      //       () => isEdit.value
                      //       ? InkWell(
                      //     onTap: () async {
                      //       imagePath.value =
                      //       await imagePickerController
                      //           .pickImage(ImageSource.gallery);
                      //
                      //
                      //       print("imagePath" + imagePath());
                      //     },
                      //     child: Container(
                      //       height: 200,
                      //       width: 200,
                      //       decoration: BoxDecoration(
                      //         color: Theme.of(context)
                      //             .colorScheme
                      //             .background,
                      //         borderRadius:
                      //         BorderRadius.circular(100),
                      //       ),
                      //       // child: profilecontroller.currentUser.value.profileImage?.isEmpty ?? true
                      //       child: profilecontroller
                      //           .currentUser
                      //           .value
                      //           .profileImage ==
                      //           "" ||
                      //           profilecontroller
                      //               .currentUser
                      //               .value
                      //               .profileImage ==
                      //               null
                      //           ? Icon(Icons.add_a_photo)
                      //           : ClipRRect(
                      //           borderRadius:
                      //           BorderRadius.circular(
                      //               100),
                      //           child: CachedNetworkImage(
                      //             placeholder: (context,url)=>
                      //                 CircularProgressIndicator(),
                      //             errorWidget: (context,url,error)=>
                      //                 Icon(Icons.error),
                      //             imageUrl: profilecontroller
                      //                 .currentUser
                      //                 .value
                      //                 .profileImage!,
                      //             fit: BoxFit.cover,
                      //           )
                      //       ),
                      //     ),
                      //   )
                      //       : Container(
                      //     height: 200,
                      //     width: 200,
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context)
                      //           .colorScheme
                      //           .background,
                      //       borderRadius:
                      //       BorderRadius.circular(100),
                      //     ),
                      //     // child: profilecontroller.currentUser.value.profileImage?.isEmpty ?? true
                      //     child: imagePath.value  ==""
                      //         ? Icon(Icons.add_a_photo)
                      //         : ClipRRect(
                      //       borderRadius:
                      //       BorderRadius.circular(
                      //           100),
                      //       child: Image.network(
                      //         profilecontroller
                      //             .currentUser
                      //             .value
                      //             .profileImage!,
                      //         fit: BoxFit.cover,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                       onChanged: (value){
                         groupName.value = value;
                      },
                        decoration: InputDecoration(
                            hintText: "Group Name",
                            prefixIcon: Icon(Icons.group)
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: groupController.groupMembers
                      .map((e) =>
                      ChatTile(
                          imageUrl: e.profileImage ??
                              AssetsImage.defoltProfileUrl,
                          name: e.name ?? "User Name",
                          lastChat: e.about ?? "",
                          lastTime: ""))
                      .toList(),
                ),
              ))
        ],
      ),
    );
  }
}
