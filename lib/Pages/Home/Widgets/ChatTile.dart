import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Config/Images.dart';

class ChatTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastChat;
  final String lastTime;
  const ChatTile({  super.key,
                    required this.imageUrl,
                    required this.name,
                    required this.lastChat,
                    required this.lastTime
                });

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 60,width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      placeholder: (context,url)=>
                          CircularProgressIndicator(),
                      errorWidget: (context,url,error)=>
                          Icon(Icons.error),
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: 60,
                    )
                  ),
                ),

                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                        style: Theme.of(context).textTheme.bodyLarge,),

                      Text(lastChat,maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge,),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Text(lastTime,
            style: Theme.of(context).textTheme.labelLarge,),
        ],

      ),
    );
  }
}
