import 'package:chatapp/Config/PagePath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../Config/Images.dart';
import '../../../Config/Strings.dart';

class WelcomeForterButton extends StatelessWidget{
  const WelcomeForterButton({super.key});
  @override
  Widget build(BuildContext context) {
  return  SlideAction(
    onSubmit: (){
      Get.offAllNamed("/authPage");
    },

    sliderButtonIcon: SvgPicture.asset(AssetsImage.pinIconSVG,width: 30,),
    submittedIcon: SvgPicture.asset(AssetsImage.bordIconSVG,width: 30,),
    text: WelcomePageStirng.sliseToStart,
   //animationDuration: Duration(seconds: 2),
    textStyle: Theme.of(context).textTheme.headlineSmall,
    innerColor: Theme.of(context).colorScheme.primaryContainer,
    outerColor: Theme.of(context).colorScheme.onPrimary,

  );
  }

}