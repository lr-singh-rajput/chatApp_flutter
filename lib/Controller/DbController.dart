import 'package:chatapp/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DbController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoding = false.obs;

  RxList<UserModel> userList = <UserModel>[].obs;


  void onInit()async{
    super.onInit();
    await getuserList();
  }

  Future<void> getuserList() async {
    isLoding.value = true;
   try{
     await db.collection("users").get().then((value) => {
       userList.value = value.docs
           .map(
             (e) => UserModel.fromJson(e.data()),
       )
           .toList()
     }
     );
   }catch(ex){
     print(ex);
   }
    isLoding.value = true;
  }
}
