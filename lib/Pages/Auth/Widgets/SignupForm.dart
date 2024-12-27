import 'package:chatapp/Controller/AuthController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Widget/PrimaryButton.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    return Column(
      children: [
        TextField(
          controller: name,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: "Enter Your full name",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter Email Address",
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: password,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter Password",
            prefixIcon: Icon(Icons.password),
          ),
        ),
        SizedBox(
          height: 57,
        ),
        Obx(
          () => authController.isLoading.value
              ? CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      btnName: "SUGNUP",
                      icon: Icons.lock_open_outlined,
                      ontap: () {
                        authController.createUser(
                            email.text, password.text, name.text);
                      },
                    ),
                  ],
                ),
        ),
        SizedBox(
          height: 21,
        ),
      ],
    );
  }
}
