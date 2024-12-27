import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Config/Images.dart';
import '../../../Config/Strings.dart';

class WelcomeBody extends StatelessWidget{
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                child: Image.asset(AssetsImage.boyPic ,)
            ),
            Container(
                height: 100,
                width: 100,
                child: SvgPicture.asset(AssetsImage.connectIconSVG)
            ),
            Container(
                height: 100,
                child: Image.asset(AssetsImage.girlPic ,)
            ),
          ],
        ),

        SizedBox(height: 50,),
        // text show
        Text(WelcomePageStirng.nowYouAre,style: Theme.of(context).textTheme.headlineMedium,),
        Text(WelcomePageStirng.connected,style: Theme.of(context).textTheme.headlineLarge,),

        SizedBox(height: 30,),

        Text(WelcomePageStirng.description,
          textAlign:TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }


}