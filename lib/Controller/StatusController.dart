import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


// show offline and online status this code

class StatusController extends GetxController with WidgetsBindingObserver{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


  @override
  void onInit() async{
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await db.collection("users").doc(auth.currentUser!.uid).update(
        { "status": "Online"});
  }
  @override
  void didChangeAppLifecycleState( AppLifecycleState state) async{
   // print("AppLifeCycleState : $state");
    if( state == AppLifecycleState.inactive){
      print("Offline");
      await db.collection("users").doc(auth.currentUser!.uid).update(
          { "status": "Offline"});
    }else if(state == AppLifecycleState.resumed){
      print("online");
      await db.collection("users").doc(auth.currentUser!.uid).update(
          { "status": "Online"});
    }

  }

  @override
  void onClose(){
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}