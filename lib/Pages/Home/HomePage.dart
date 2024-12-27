import 'package:chatapp/Config/PagePath.dart';
import 'package:chatapp/Controller/ContactController.dart';
import 'package:chatapp/Controller/ImagePicker.dart';
import 'package:chatapp/Controller/StatusController.dart';
import 'package:chatapp/Pages/Groups/GroupsPage.dart';
import 'package:chatapp/Pages/Home/Widgets/ChatsList.dart';
import 'package:chatapp/Pages/Home/Widgets/TabBar.dart';
import 'package:chatapp/Pages/ProfilePage/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Config/Images.dart';
import '../../Config/Strings.dart';
import '../../Controller/profileController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {

    Profilecontroller profilecontroller = Get.put(Profilecontroller());
  ImagePickerController imagePickerController = Get.put(ImagePickerController());
  ContactController contactController = Get.put(ContactController());
  StatusController statusController  = Get.put(StatusController());
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AssetsImage.appIconSVG,
          ),
        ),
        //leading: SvgPicture.asset(AssetImage.appIconSVG)// video - 13:45,
        actions: [
          IconButton(onPressed: ()  async{
           // Get.toNamed('/profilePage');
            await profilecontroller.getUserDetails();
            Get.to(Profilepage());
          }, icon: Icon(Icons.more_vert)),

          IconButton(onPressed: () {
            contactController.getChatRoomList();
          }, icon: Icon(Icons.search)),
        ],
        bottom: myTabBar(tabController,context),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.toNamed("/contactPage");
      },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: TabBarView(
          controller: tabController,
          children: [
            ChatsList(),

          GroupPage(),
            ListView(
              children: [
                ListTile(
                  title: Text("Name Calls "),
                 )
               ],
            ),
        ]
      ),
    );
  }
}
