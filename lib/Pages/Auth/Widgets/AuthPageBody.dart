import 'package:chatapp/Pages/Auth/Widgets/LoginForm.dart';
import 'package:chatapp/Pages/Auth/Widgets/SignupForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageBody extends StatelessWidget{
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;

    return Container(
        padding: EdgeInsets.all(20),
       // height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(()=> Column(
            children: [
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(

                        children: [
                          Row(
                         //   mainAxisAlignment: MainAxisAlignment.center,


                            children: [
                            InkWell(
                              onTap: (){
                                isLogin.value=true;
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width/3,
                                child: Column(

                                  children: [
                                    Text("LogIn",style: isLogin.value
                                    ? Theme.of(context).textTheme.headlineSmall
                                     : Theme.of(context).textTheme.bodyLarge),

                                    SizedBox(height: 5,),
                                    AnimatedContainer(duration: Duration(seconds: 1),
                                      width: isLogin.value ? 100 : 0,
                                      height: 7,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.background,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Expanded(
                    child: Column(
                      children: [
                        Row(
                         // mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            InkWell(
                              onTap: (){
                                isLogin.value = false;
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width/3,
                                child: Column(


                                  children: [
                                    Text("SignUp",style: isLogin.value
                                    ? Theme.of(context).textTheme.bodyLarge
                                    : Theme.of(context).textTheme.headlineSmall),
                                    SizedBox(height: 5,),
                                    AnimatedContainer(duration: Duration(seconds: 1),
                                      width: isLogin.value ? 0 : 100,
                                      height: 7,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.background,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                ),
                        ],
                      ),
              SizedBox(height: 20,),

              Obx(()=> isLogin.value ? LoginForm() : SignupForm()),
            ],
          ),
          ) ,
      );

  }

}