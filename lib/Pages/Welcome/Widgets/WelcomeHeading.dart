import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Config/Images.dart';
import '../../../Config/Strings.dart';

class WelcomeHeading extends StatelessWidget{
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsImage.appIconSVG),
          ],
        ),
        SizedBox(height: 20,),
        Text(AppString.appName,
            style: Theme.of(context).textTheme.headlineLarge//?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),

      ],
    );
  }


}