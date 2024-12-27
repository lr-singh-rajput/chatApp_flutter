import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Controller/ContactController.dart';
import 'package:chatapp/Controller/GroupController.dart';
import 'package:chatapp/Pages/Groups/NewGroup/GroupTitle.dart';
import 'package:chatapp/Pages/Groups/NewGroup/SelectedMemberList.dart';
import 'package:chatapp/Pages/Home/Widgets/ChatTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: Text(" New Group"),
      ),
      floatingActionButton: Obx(()=>
          FloatingActionButton(
            backgroundColor: groupController.groupMembers.isEmpty ? Colors.grey: Colors.blue,
            onPressed: () {
              if(groupController.groupMembers.isEmpty){
                Get.snackbar("Error","Please Select Atleast One Member");
              }else{
                Get.to(GroupTitle());
              }
            }, child: Icon(Icons.arrow_forward,color: Colors.white,),),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SelectedMemberList(),

            SizedBox(height: 10,),
            Row(
              children: [
                Text('Contact On ChatApp', style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium,),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder(
                stream: contactController.getContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error:${snapshot.error}"),
                    );
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: Text("No Message"),
                    );
                  } else {
                    return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor:  Colors.transparent,
                            onTap: (){
                              groupController.selectMember(snapshot.data![index]);
                            },
                            child: ChatTile(
                                imageUrl: snapshot.data![index].profileImage ??
                                    AssetsImage.defoltProfileUrl,
                                name: snapshot.data![index].name ?? "User Name",
                                lastChat: snapshot.data![index].about ??
                                    "No About",
                                lastTime: ""),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
