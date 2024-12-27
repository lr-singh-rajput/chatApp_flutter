import 'package:chatapp/Config/CustomMessage.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Model/GroupModel.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:chatapp/Pages/Home/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Model/ChatModel.dart';

class GroupController extends GetxController {
  Profilecontroller profilecontroller = Get.put(Profilecontroller());
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var uuid = Uuid();
  RxList<UserModel> groupMembers = <UserModel>[].obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;

  RxBool isLoading = false.obs;
  RxString selectedImagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v6();

    groupMembers.add(
      UserModel(
        id: auth.currentUser!.uid,
        name: profilecontroller.currentUser!.value.name,
        profileImage: profilecontroller.currentUser!.value.profileImage,
        email: profilecontroller.currentUser!.value.email,
        role: "admin",
      ),
    );

    try {
      String imageUrl = await profilecontroller.uploadFileToFirebase(imagePath);
      await db.collection("groups").doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createAt": DateTime.now().toString(),
        "createdBy": auth.currentUser!.uid,
        "timeStamp": DateTime.now().toString(),
      });

      //Group Created Toast
      //Get.snackbar("Group Created", " Group Created Successfully");
      successMessage("Group Created ");

      Get.offAll(HomePage());
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getGroups() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    // yaha par shabhi group aa rahe hai jo bhi data base ke andar hai
    await db.collection("groups").get().then(
      (value) {
        tempGroup = value.docs
            .map(
              (e) => GroupModel.fromJson(e.data()),
            )
            .toList();
      },
    );
    groupList.clear();
    groupList.value = tempGroup
        .where(
          (e) => e.members!.any(
            // jis jis group me me rahu use show kare filter kar ke show kkare ge
            (element) => element.id == auth.currentUser!.uid,
          ),
        )
        .toList();
    isLoading.value = false;
  }

  Future<void> sendGroupMessage(
      String message, String groupId, String imagePath) async {
    isLoading.value = true;
    var chatId = uuid.v6();
    String imageUrl =
        await profilecontroller.uploadFileToFirebase(selectedImagePath.value);
    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl,
      senderId: auth.currentUser?.uid,
      timestamp: DateTime.now().toString(),
      senderName: profilecontroller.currentUser.value.name,
    );
    await db
        .collection("groups")
        .doc(groupId)
        .collection("massages")
        .doc(chatId)
        .set(
          newChat.toJson(),
        );
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getGroupMessage(String groupId) {
    return db
        .collection("groups")
        .doc(groupId)
        .collection("massages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => ChatModel.fromJson(doc.data()),
            )
            .toList());
  }

  Future<void> addMemberToGroup(String groupId,UserModel user) async{
      isLoading.value = true;
      await db.collection("groups").doc(groupId).update(
        {
          "members": FieldValue.arrayUnion([user.toJson()]),
        }
      );
      getGroups();
      isLoading.value = false;
  }
}
