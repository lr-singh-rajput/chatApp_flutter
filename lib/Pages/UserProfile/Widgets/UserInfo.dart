import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Config/Images.dart';
import '../../../Controller/profileController.dart';

class LoginUserInfo extends StatelessWidget {
 final String profileImage;
 final String userName;
 final String userEmail;
  const LoginUserInfo({super.key, required this.profileImage, required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {

    Profilecontroller profilecontroller = Get.put(Profilecontroller());

    return   Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 150,
                        height: 150,
                        child: ClipRRect(

                            borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            placeholder: (context,url)=>
                                CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>
                                Icon(Icons.error),
                            imageUrl: profileImage!,
                            fit: BoxFit.cover,
                          )
                            )),
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text(userName,
                      style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                 Text(userEmail,
                    style: Theme.of(context).textTheme.labelLarge,)
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.call),
                          SizedBox(width: 19,),
                          Text('Call'),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(15),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.video_call),
                          SizedBox(width: 19,),
                          Text('Video'),
                        ],
                      ),
                    ),

                    Container(
                      height: 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.chat),
                          SizedBox(width: 19,),
                          Text('Chat'),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
