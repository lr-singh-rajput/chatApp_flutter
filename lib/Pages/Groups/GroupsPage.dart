import 'package:chatapp/Controller/GroupController.dart';
import 'package:chatapp/Pages/GroupChat/GroupChat.dart';
import 'package:chatapp/Pages/Home/Widgets/ChatTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Config/Images.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController =Get.put(GroupController());
    return Obx(
          () =>ListView(
        children: groupController.groupList
            .map(
              (group) => InkWell(
                onTap: () {
                    Get.to(GroupChat(groupModel: group));
                },
                child: ChatTile(
                    imageUrl: group.profileUrl == ""
                        ? AssetsImage.defoltProfileUrl
                        : group.profileUrl!,
                    name: group.name!,
                    lastChat: "Group Created",
                    lastTime: "Just Time"
                ),
              ),
            ).toList(),
      ),

    );
  }
}
