import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget{
  final String btnName;
  final IconData icon;
  final VoidCallback ontap;

  const PrimaryButton({
    super.key,
    required this.btnName,
    required this.icon,
    required this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(

        //padding: EdgeInsets.all(11),
        padding: EdgeInsets.symmetric(horizontal: 35,vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 10,),
            Text(btnName,style:Theme.of(context).textTheme.bodyLarge,)
          ],
        ),
      ),
    );
  }
}