import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Widget/PrimaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/AuthController.dart';
import '../../Controller/ImagePicker.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    RxBool isEdit = false.obs;

    Profilecontroller profilecontroller = Get.put(Profilecontroller());
    TextEditingController name =
        TextEditingController(text: profilecontroller.currentUser.value.name);
    TextEditingController email =
        TextEditingController(text: profilecontroller.currentUser.value.email);
    TextEditingController phone = TextEditingController(
        text: profilecontroller.currentUser.value.phoneNumber);
    TextEditingController about =
        TextEditingController(text: profilecontroller.currentUser.value.about);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
                btnName: "logOut",
                icon: Icons.logout,
                ontap: () {
                  authController.logoutUser();
                })
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(() => Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => isEdit.value
                                      ? InkWell(
                                          onTap: () async {
                                            imagePath.value =
                                                await imagePickerController
                                                    .pickImage(ImageSource.gallery);


                                            print("imagePath" + imagePath());
                                          },
                                          child: Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            // child: profilecontroller.currentUser.value.profileImage?.isEmpty ?? true
                                            child: profilecontroller
                                                            .currentUser
                                                            .value
                                                            .profileImage ==
                                                        "" ||
                                                    profilecontroller
                                                            .currentUser
                                                            .value
                                                            .profileImage ==
                                                        null
                                                ? Icon(Icons.add_a_photo)
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CachedNetworkImage(
                                                      placeholder: (context,url)=>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,url,error)=>
                                                          Icon(Icons.error),
                                                      imageUrl: profilecontroller
                                                                .currentUser
                                                                .value
                                                                .profileImage!,
                                                      fit: BoxFit.cover,
                                                          )
                                                  ),
                                          ),
                                        )
                                      : Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          // child: profilecontroller.currentUser.value.profileImage?.isEmpty ?? true
                                          child: profilecontroller.currentUser
                                                          .value.profileImage ==
                                                      "" ||
                                                  profilecontroller.currentUser
                                                          .value.profileImage ==
                                                      null
                                              ? Icon(Icons.add_a_photo)
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.network(
                                                    profilecontroller
                                                        .currentUser
                                                        .value
                                                        .profileImage!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => TextField(
                                controller: name,
                                enabled: isEdit.value,
                                decoration: InputDecoration(
                                  filled: isEdit.value,
                                  labelText: 'Name',
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: email,
                              enabled: false,
                              decoration: InputDecoration(
                                filled: isEdit.value,
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.alternate_email),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => TextField(
                                controller: about,
                                enabled: isEdit.value,
                                decoration: InputDecoration(
                                  filled: isEdit.value,
                                  labelText: 'About',
                                  prefixIcon: Icon(Icons.info),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => TextField(
                                controller: phone,
                                enabled: isEdit.value,
                                decoration: InputDecoration(
                                  filled: isEdit.value,
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() => isEdit.value
                                    ? PrimaryButton(
                                        btnName: "Save",
                                        icon: Icons.save,
                                        ontap: () async {
                                          isEdit.value = false;
                                          await profilecontroller.updateProfile(
                                              imagePath(),
                                              name.text,
                                              about.text,
                                              phone.text);
                                         // await profilecontroller
                                            //  .getUserDetails();
                                        })
                                    : PrimaryButton(
                                        btnName: "Edit",
                                        icon: Icons.edit,
                                        ontap: () {
                                          isEdit.value = true;
                                        }))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
