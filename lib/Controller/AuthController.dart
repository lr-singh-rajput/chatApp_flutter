import 'package:chatapp/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  // for login user
  Future<void> login(String email,String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/homePage');
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        print('No user found for that email');
      }else if (e.code == 'wrong-password'){
        print('Wrong password provided for that user');
      }else{
        print(e.code);
      }
    }catch (e){
      print(e);
    }
    isLoading.value = false;

  }


  //For Create user
  Future<void> createUser(String email,String password,String name)async {
    isLoading.value = true;
    try{
      await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
          );
      await initUser(email,name);
      Get.offAllNamed('/homePage');
      print('Acount created ');

    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        print('The password provided is too weak');
      }else if(e.code == 'email-already-in-use'){
        print('The account already exists for that email');
      }
    }
    catch(e){
      print(e);
    }
    isLoading.value = false;
  }


  // for logOut user
Future<void> logoutUser() async {
    await auth.signOut();
    Get.offAllNamed('/authPage');
}

//for save user detail in firestore database
Future<void> initUser(String email,String name) async{
    var newUser = UserModel(
      email: email,
      name: name,
      id:auth.currentUser?.uid,
    );
    try{
      await db.collection("users").doc(auth.currentUser?.uid).set(
          newUser.toJson()
      );
    }catch(ex){
      print('not save user in data base ');
      print(ex);
      print('not save code end errors');

    }


}

}