import 'package:chatapp/Model/AudioCallModel.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v4();

  void onInit(){
    super.onInit();

    getCallNotification().listen((snapshot){
      if (snapshot.docs.isNotEmpty){
Get.snackbar("Calling", "Calling");
      }
    });
  }

  // SnackBar snackBar =  SnackBar(
  //   content: Text("You Have A Call"),
  //   action: SnackBarAction(
  //       label: "Accept",
  //       onPressed: (){
  //         ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  //         print("Accepted");
  //       }),
  // );
  // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

  Future<void> callAction(UserModel receiver ,UserModel caller) async{
    String id = uuid;
    var newCall = AudioCallModel(
      id : id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverName: receiver.name,
      receiverPic: receiver.profileImage,
      receiverUid: receiver.id,
      receiverEmail: receiver.email,
      status: "dialing"
    );
    try{

      // notification for
      await db
          .collection("notification")
          .doc(receiver.id)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());

      // save jo user call kar raha hai
      await db.collection("users").doc(auth.currentUser!.uid)
              .collection("calls").doc(id)
              .set(newCall.toJson());
      // save jis ke pass call ja raha hai
      await db.collection("users").doc(receiver.id)
              .collection("calls").doc(id)
              .set(newCall.toJson());

      //delete notification kyo ki notification sirf user tak jay fir kuch der me delete ho jay
Future.delayed(Duration(seconds: 20),(){
      endCall(newCall);
    });
    }catch(e){
      print(e);
    }
  }
  //delete notification kyo ki notification sirf user tak jay fir kuch der me delete ho jay
  Future<void> endCall (AudioCallModel call) async{
  try {
    await db
        .collection("notification")
        .doc(call.receiverUid)
        .collection("call")
        .doc(call.id)
        .delete();
  }catch (e){
    print(e);
  }
  }
  Stream<QuerySnapshot> getCallNotification(){
    return db
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots();

  }


  
  
}