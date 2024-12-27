import 'package:chatapp/Controller/ChatController.dart';
import 'package:chatapp/Controller/ContactController.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Pages/Chat/ChatPage.dart';
import 'package:chatapp/Pages/ContactPage/Widgets/ContactSearch.dart';
import 'package:chatapp/Pages/ContactPage/Widgets/NewContatcTile.dart';
import 'package:chatapp/Pages/Groups/NewGroup/NewGroup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Config/Images.dart';
import '../Home/Widgets/ChatTile.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ChatController chatController =Get.put(ChatController());
    Profilecontroller profilecontroller = Get.put(Profilecontroller());

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Contact'),
        backgroundColor: Colors.white12,
        actions: [
          Obx(() =>
              IconButton(onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
                  icon: isSearchEnable.value ? Icon(Icons.close) : Icon(
                      Icons.search)),
          )
        ],
      ),
      body: ListView(
        children: [

          Obx(() => isSearchEnable.value ? ContactSearch() : SizedBox(),
          ),
          SizedBox(height: 10,),
          NewContactTile(
              btnName: "New Contact",
              icon: Icons.person_add,
              ontab: () {}
          ),
          SizedBox(height: 10,),
          NewContactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              ontab: () {
            Get.to(NewGroup());
              }
          ),
          SizedBox(height: 10,),

          Row(
            children: [
              Text('Contact On ChatApp'),
            ],
          ),
          Obx(() {
            return Column(
              children: contactController.userList.map((e) =>
                  InkWell(
                   splashColor: Colors.transparent,// is se click karne par backgound par color change nhi hoga
                   highlightColor: Colors.transparent,// is se click karne par backgound par color change nhi hoga
                    onTap: () {
                     // Get.toNamed("/chatPage",arguments: e);
                      Get.to(ChatPage(userModel:e));
                     // String roomID = chatController.getRoomId(e.id!);
                    //  print(roomID);
                    },
                    child: ChatTile(
                      imageUrl: e.profileImage ?? AssetsImage.defoltProfileUrl,
                      name: e.name ?? 'User',
                      lastChat: e.about ?? "hey there",
                      lastTime: e.email == profilecontroller.auth.currentUser!.email
                        ? "you"
                        : "",
                    ),
                  )
              ).toList(),
            );
          })
        ],
      ),
    );
  }
}
