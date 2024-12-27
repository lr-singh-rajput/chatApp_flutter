import 'package:chatapp/Pages/Auth/AuthPage.dart';
import 'package:chatapp/Pages/Chat/ChatPage.dart';
import 'package:chatapp/Pages/ContactPage/ContactPage.dart';
import 'package:chatapp/Pages/Home/HomePage.dart';
import 'package:chatapp/Pages/UserProfile/ProfilePage.dart';
import 'package:chatapp/Pages/UserProfile/Widgets/UpdateProfile.dart';
import 'package:get/get.dart';

var pagePath = [
  GetPage(
      name: "/authPage",
      page:()=> AuthPage(),
    transition: Transition.rightToLeft,
  ),

  //home page
  GetPage(
      name: "/homePage",
      page:()=> HomePage(),
    transition: Transition.rightToLeft,
  ),

  //chatpage
  // GetPage(
  //     name: "/chatPage",
  //     page:()=> ChatPage(),
  //   transition: Transition.rightToLeft,
  // ),

  //contact page
  GetPage(
      name: "/contactPage",
      page:()=> ContactPage(),
    transition: Transition.rightToLeft,
  ),

  // //profile page
  // GetPage(
  //     name: "/profilePage",
  //     page:()=> UserProfilePage(),
  //   transition: Transition.rightToLeft,
  // ),
  //
  // //updateprofile page
  // GetPage(
  //   name: "/updateProfilePage",
  //   page:()=> UserUpdateProfile(),
  //   transition: Transition.rightToLeft,
  // ),
];