import 'package:chatapp/Controller/AuthController.dart';
import 'package:chatapp/Widget/PrimaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginForm extends StatelessWidget{
  const LoginForm({super.key});



  @override
  Widget build(BuildContext context) {

    AuthController authController = Get.put(AuthController());


    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
   return Column(
     children: [
      TextField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Enter Email Address",
        prefixIcon: Icon(Icons.email),
        ),
      ),

      SizedBox(height: 20,),

      TextField(
        controller: password,
        keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: "Enter Password",
        prefixIcon: Icon(Icons.password),
        ),
      ),
       SizedBox(height: 57,),
       
      Obx(() =>   authController.isLoading.value ? CircularProgressIndicator() :  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(btnName: "LOGIN",
            icon: Icons.lock_open_outlined,
            ontap: (){
              authController.login(email.text, password.text);
              // Get.offAllNamed("/homePage");
              },
            ),
          ],
        ),
      ),
       SizedBox(height: 21,),
     ],
   );
  }


}