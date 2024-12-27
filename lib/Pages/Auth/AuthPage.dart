import 'package:chatapp/Pages/Auth/Widgets/AuthPageBody.dart';
import 'package:chatapp/Pages/Auth/Widgets/LoginForm.dart';
import 'package:chatapp/Pages/Welcome/Widgets/WelcomeHeading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                WelcomeHeading(),

                SizedBox(height: 50,),

                AuthPageBody(),

                //Login Form Code


              ],
            ),
          ),
        ),
      ),
   );
  }

}