import 'dart:io';
import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Model/GroupModel.dart';
import 'package:chatapp/Pages/GroupInfo/GroupMemberInfo.dart';
import 'package:chatapp/Pages/Home/Widgets/ChatTile.dart';
import 'package:chatapp/Pages/UserProfile/Widgets/UserInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            GroupMemberInfo(
              groupId:  groupModel.id!,
              profileImage: groupModel.profileUrl== ""
                  ? AssetsImage.defoltProfileUrl
                  : groupModel.profileUrl!,
              userName: groupModel.name!,
              userEmail: groupModel.description ?? "No Description Available",
            ),
            SizedBox(height: 20,),
          Text("members",style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: 10,),
            Column(
              children: groupModel.members!.map((member)=> ChatTile(
                  imageUrl: member.profileImage ?? AssetsImage.defoltProfileUrl,
                  name: member.name!,
                  lastChat: member.email!,
                  lastTime: member.role == "admin" ? "Admin" : "User",
                ),
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
}
