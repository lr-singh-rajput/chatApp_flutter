import 'package:chatapp/Controller/ContactController.dart';
import 'package:chatapp/Controller/profileController.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Model/ChatRoomModel.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController{
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  var uuid = Uuid();
  RxString selectedImagePath = "".obs;
  Profilecontroller profilecontroller = Get.put(Profilecontroller());

  ContactController contactController = Get.put(ContactController());
  RxBool isLoading =false.obs;


  String getRoomId(String targetUserId){
    String currentUserId = auth.currentUser!.uid;

    if(currentUserId[0].codeUnitAt(0)> targetUserId[0].codeUnitAt(0)){
      return currentUserId+targetUserId;
    }else{
      return targetUserId+currentUserId;
    }
  }

  UserModel getSender (UserModel currentUser, UserModel targetUser){
    String currentUserId =currentUser!.id!;
    String targetUserId = targetUser!.id!;
    if( currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
      return currentUser;
    }else{
      return targetUser;
    }
  }

  UserModel getReciver(UserModel currentUser, UserModel targetUser){
    String currentUserId =currentUser!.id!;
    String targetUserId = targetUser!.id!;
    if( currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
      return targetUser;
    }else{
      return currentUser;
    }
  }

  Future<void> sendMessage(String targetUserId,String message,UserModel targetUser) async{
    isLoading.value = true;
    String chatId = uuid.v6(); // genrate unick id evry time
    String roomId = getRoomId(targetUserId);
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm:a').format(timestamp);

    UserModel sender = getSender(profilecontroller.currentUser.value, targetUser);
    UserModel receiver = getReciver(profilecontroller.currentUser.value, targetUser);

    RxString imageUrl = "".obs;
    if(selectedImagePath.value.isNotEmpty){
      imageUrl.value = await profilecontroller.uploadFileToFirebase(selectedImagePath.value);
    }

    var newChat = ChatModel(
      id:  chatId,
      message: message,
      imageUrl: imageUrl.value,
      senderId: auth.currentUser?.uid,
      receiverId: targetUserId,
      timestamp: DateTime.now().toString(),
      senderName: profilecontroller.currentUser.value.name,
    );

    // Future<void> sendMessage(String targetUserId,String message,UserModel targetUser) async{
    // isLoading.value = true;
    // String chatId = uuid.v6();
    // String roomId = getRoomId(targetUserId);
    // DateTime timestamp = DateTime.now();
    // String nowTime = DateFormat('hh:mm:a').format(timestamp);
    // var newChat = ChatModel(
    //   id:  chatId,
    //   message: message,
    //   senderId: auth.currentUser?.uid,
    //   receiverId: targetUserId,
    //   timestamp: DateTime.now().toString(),
    //   senderName: profilecontroller.currentUser.value.name,
    // );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimestamp: nowTime,
      sender:  sender,
      receiver : receiver,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );
    try{
      await db
          .collection("chats")
          .doc(roomId)
          .collection("massages")
          .doc(chatId)
          .set(
              newChat.toJson(),
            );
      selectedImagePath.value ="";
      await db
          .collection("chats")
          .doc(roomId)
          .set(
          roomDetails.toJson()
      );

      await contactController.saveContact(targetUser);
      }catch(e){
        print(e);
    }
    isLoading.value = false;
  }

  //real time update and show data
  Stream<List<ChatModel>> getMessages(String targetUserId){
    String roomId = getRoomId(targetUserId);
    return db
            .collection("chats")
            .doc(roomId)
            .collection("massages")
            .orderBy("timestamp",descending: true)
            .snapshots()
            .map(
              (snapshot)=> snapshot.docs
                  .map(
                        (doc) => ChatModel.fromJson(doc.data()),
                  )
                  .toList());
    }

    Stream<UserModel> getStatus(String uid){
    return db.collection("users").doc(uid).snapshots().map(
        (event){
          return UserModel.fromJson(event.data()!);
        }
    );
    }
}
