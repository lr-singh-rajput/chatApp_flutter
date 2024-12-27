import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Config/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatBubble extends StatelessWidget {
  final String massage;
  final bool isComming;
  final String time;
  final String status;
  final String imageUrl;
  const ChatBubble(
      {super.key,
      required this.massage,
      required this.isComming,
      required this.time,
      required this.status,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints(
                //  maxHeight: ,
                maxWidth: MediaQuery.sizeOf(context).width / 1.3,
                // minHeight: ,
                //minWidth: 80,
              ),
              decoration: BoxDecoration(
                  borderRadius: isComming
                      ? BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: imageUrl == ""
                  ? Text(massage)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                            child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                        )),
                        massage == ""
                            ? Container()
                            : Text(
                                massage,
                              ),
                        massage == ""
                            ? Container()
                            : Text(
                                massage,
                              ),
                      ],
                    )),
          Row(
            mainAxisAlignment:
                isComming ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              isComming
                  ? Text(
                      time,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  : Row(
                      children: [
                        Text(
                          time,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        SvgPicture.asset(
                          AssetsImage.chatStatusSVG,
                          width: 15,
                        ),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }
}
