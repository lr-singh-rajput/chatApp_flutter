import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Controller/SplaceController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Splacepage extends StatelessWidget{
  const Splacepage ({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController =Get.put(SplaceController());
   return Scaffold(

     body: Center(
            child: SvgPicture.asset(AssetsImage.appIconSVG),
       ),
     );

  }
}