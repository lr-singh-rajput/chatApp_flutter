import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController{
  final auth = FirebaseAuth.instance;

  void onInit() async{
    super.onInit();
    await spalceHandel();
  }

  Future<void> spalceHandel() async{
    Future.delayed(Duration(seconds: 4),(){
        if(auth.currentUser == null ){
          Get.offAllNamed('/authPage');
        }else{
          Get.offAllNamed('/homePage');
        }
      }
    );

  }
}