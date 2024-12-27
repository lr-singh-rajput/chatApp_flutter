import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Config/PagePath.dart';
import 'package:chatapp/Controller/ContactController.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Pages/Chat/ChatPage.dart';
import 'package:chatapp/Pages/Home/Widgets/ChatTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    Profilecontroller profilecontroller = Get.put(Profilecontroller());
    return RefreshIndicator(child:  Padding(
      padding: const EdgeInsets.all(13.0),
      child: Obx(() {
        return ListView(
            children:contactController.chatRoomList
                .map(
                  (e)=> InkWell(
                    splashColor: Colors.transparent,// is se click karne par backgound par color change nhi hoga
                    highlightColor: Colors.transparent,// is se click karne par backgound par color change nhi hoga
                    onTap: (){
                  Get.to(
                      ChatPage(
                          userModel:( e.receiver!.id ==
                              profilecontroller.currentUser.value.id
                            ? e.sender
                            : e.receiver)!
                      ),
                  );
                },
                child: ChatTile(
                  imageUrl:( e.receiver!.id ==
                              profilecontroller.currentUser.value.id
                          ? e.sender!.profileImage
                          : e.receiver!.profileImage) ?? AssetsImage.defoltProfileUrl,
                  name: (e.receiver!.id ==
                          profilecontroller.currentUser.value.id
                        ? e.sender!.name
                        : e.receiver!.name)!,
                  lastChat: e.lastMessage ?? "LastMessage",
                  lastTime: e.lastMessageTimestamp ?? "Last Time",
                ),
              ),
            ).toList()
        );
      }),
    ), onRefresh: (){
      return contactController.getChatRoomList();
    });
  }
}
