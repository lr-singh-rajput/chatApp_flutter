import 'package:chatapp/Config/Images.dart';
import 'package:chatapp/Config/Strings.dart';
import 'package:chatapp/Pages/Welcome/Widgets/WelcomeHeading.dart';
import 'package:chatapp/Pages/Welcome/Widgets/WelcomesFooterButton.dart';
import 'package:chatapp/Pages/Welcome/Widgets/welcomeBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomePage extends StatelessWidget{
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return const Scaffold(
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [

             // heading logo and name
             WelcomeHeading(),


             // image ,icon,text
             WelcomeBody(),


             //  slider btn code
            WelcomeForterButton(),




           ],
         ),
       ),
     ),
   );
  }

}