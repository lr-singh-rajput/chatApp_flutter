import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Controller/CallController.dart';
import 'package:chatapp/Controller/ChatController.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:chatapp/Pages/Chat/Widget/ChatBubble.dart';
import 'package:chatapp/Pages/Chat/Widget/TypeMessage.dart';
import 'package:chatapp/Pages/UserProfile/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    Profilecontroller profilecontroller = Get.put(Profilecontroller());
    TextEditingController messageController = TextEditingController();
    CallController callController = Get.put(CallController());
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
                Get.to(UserProfilePage(userModel: userModel,));
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
                          imageUrl: userModel.profileImage ?? AssetsImage.defoltProfileUrl,
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
                Get.to(UserProfilePage(userModel: userModel,));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userModel.name ?? "User Name",style: Theme.of(context).textTheme.bodyLarge,),
                 StreamBuilder(stream: chatController.getStatus(userModel.id!),
                     builder: (context,snapshot)
                     {
                       if(snapshot.connectionState == ConnectionState.waiting){
                         return Text(".......");
                       }else{
                         return Text(snapshot.data!.status ?? "",style: TextStyle(
                           fontSize: 12,
                           color:  snapshot.data!.status == "Online"
                               ? Colors.green
                               : Colors.grey,
                         ),);
                       }


                     })
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            callController.callAction(userModel, profilecontroller.currentUser.value);
          }, icon: Icon(Icons.call)),
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
                        stream: chatController.getMessages(userModel.id!),
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
                                    isComming: snapshot.data![index].receiverId == profilecontroller.currentUser.value.id,
                                    status: "read",
                                    time: formattedTime,

                                );

                              }
                            );
                          }
                        },
                    ),

                  Obx(()=>
                      (chatController.selectedImagePath.value!= "")
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
                                          chatController.selectedImagePath.value)
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
                                      chatController.selectedImagePath.value ="";
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
            TypeMessage(userModel: userModel)
          ],
        )

          ),
      );
  }
}

