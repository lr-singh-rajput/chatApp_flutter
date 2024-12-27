import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Config/PagePath.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:chatapp/Pages/UserProfile/Widgets/UserInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/AuthController.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel userModel;
  const UserProfilePage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed('updateProfilePage');
          }, icon: Icon(Icons.edit)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
          LoginUserInfo(
            profileImage: userModel.profileImage ??AssetsImage.defoltProfileUrl,
            userEmail: userModel.email ?? "",
            userName: userModel.name?? "",
          ),

            Spacer(),
            ElevatedButton(onPressed: (){
              authController.logoutUser();
            }, child: Text('LogOut'),)
          ],
        ),
      ),
    );
  }
}
