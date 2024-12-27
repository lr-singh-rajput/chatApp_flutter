import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Controller/ChatController.dart';
import 'package:chatapp/Controller/GroupController.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Model/GroupModel.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:chatapp/Pages/Chat/Widget/ChatBubble.dart';
import 'package:chatapp/Pages/Chat/Widget/TypeMessage.dart';
import 'package:chatapp/Pages/GroupInfo/GroupInfo.dart';
import 'package:chatapp/Pages/UserProfile/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'GroupTypeMessage.dart';

class GroupChat extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChat({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
   // ChatController chatController = Get.put(ChatController());
    GroupController groupController = Get.put(GroupController());
    Profilecontroller profilecontroller = Get.put(Profilecontroller());
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        //    leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back)),
        title: Row(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                splashColor: Colors.transparent,// is se click karne par backgound par color change nhi hoga
                highlightColor: Colors.transparent,// is se click karne par backgound par color change nhi hoga
                onTap: (){
                  Get.to(GroupInfo(groupModel: groupModel));
                },
                child: Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          placeholder: (context,url)=>
                              CircularProgressIndicator(),
                          errorWidget: (context,url,error)=>
                              Icon(Icons.error),
                          imageUrl: groupModel.profileUrl == ""
                              ? AssetsImage.defoltProfileUrl
                              : groupModel.profileUrl!,
                          fit: BoxFit.cover,
                          width: 60,
                        )
                    )
                )
            ),
            SizedBox(width: 15,),
            InkWell(
              splashColor: Colors.transparent,// is se click karne par backgound par color change nhi hoga
              highlightColor: Colors.transparent,
              onTap: (){
              //  Get.to(UserProfilePage(userModel: userModel,));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(groupModel.name ?? "Group02 Name",style: Theme.of(context).textTheme.bodyLarge,),
                  Text("Online",style: Theme.of(context).textTheme.labelSmall,),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.call)),
          IconButton(onPressed: (){}, icon: Icon(Icons.video_call)),
        ],
      ),


      body: Padding(
          padding: const EdgeInsets.only(bottom: 10,top: 10,left: 10,right: 10),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                    children :[
                      StreamBuilder(
                        stream:groupController.getGroupMessage(groupModel.id!),
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          if(snapshot.hasError){
                            return Center(child: Text("Error:${snapshot.error}"),
                            );
                          }
                          if(snapshot.data == null){
                            return Center(child: Text("No Message"),
                            );
                          }
                          else{
                            return ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context,index){
                                  DateTime timestamp =
                                  DateTime.parse(snapshot.data![index].timestamp!);
                                  String formattedTime = DateFormat('hh:mm:a').format(timestamp);
                                  return ChatBubble(
                                    massage: snapshot.data![index].message!,
                                    imageUrl: snapshot.data![index].imageUrl ?? "",
                                    isComming: snapshot.data![index].senderId != profilecontroller.currentUser.value.id,
                                    status: "read",
                                    time: formattedTime,

                                  );

                                }
                            );
                          }
                        },
                      ),

                      Obx(()=>
                      (groupController.selectedImagePath.value!= "")
                          ? Positioned(
                          bottom: 0,right: 0,left: 0,
                          child: Stack(
                              children:[
                                Container(
                                  height: 500,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                          File(
                                              groupController.selectedImagePath.value)
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: IconButton(onPressed: (){
                                      groupController.selectedImagePath.value ="";
                                    },
                                        icon: Icon(Icons.close))
                                ),
                              ]
                          )
                      )
                          : Container()

                      )
                    ]
                ),
              ),
              GroupTypeMessage(groupModel: groupModel)
            ],
          )

      ),
    );
  }
}

