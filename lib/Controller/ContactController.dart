import 'package:chatapp/Model/ChatRoomModel.dart';
import 'package:chatapp/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  void onInit() async {
    super.onInit();
    await getuserList();
    await getChatRoomList();
  }
  // RxBool isLoding = false.obs;
  //
  // RxList<UserModel> userList = <UserModel>[].obs;
  // RxList<ChatRoomModel> chatRoomModel= <ChatRoomModel>[].obs;
  //
  //
  // void onInit()async{
  //   super.onInit();
  //   await getuserList();
  //   await getChatRoomList();
  // }

  Future<void> getuserList() async {
    isLoading.value = true;
    try{
      userList.clear();
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
    isLoading.value = true;
  }

  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempChatRoom = [];
    await db
        .collection('chats')
        .orderBy("timestamp", descending: true)
        .get()
        .then(
          (value) {
        tempChatRoom = value.docs
            .map(
              (e) => ChatRoomModel.fromJson(e.data()),
        )
            .toList();
      },
    );
    chatRoomList.value = tempChatRoom
        .where(
          (e) => e.id!.contains(
        auth.currentUser!.uid,
      ),
    )
        .toList();

    print(chatRoomList);
  }

  Future<void> saveContact(UserModel user) async{
    try{
      await db.collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .doc(user.id)
        .set(user.toJson());

    }catch(e){
      print("Error While saving cOntact"+ e.toString());
    }
  }

//   Future<void> getChatRoomList() async{
//     List<ChatRoomModel> tempChatRoom = [];
//     await db.collection("chats").get().then(
//             (value){
//               tempChatRoom = value.docs
//                   .map(
//                     (e)=> ChatRoomModel.fromJson(e.data()),
//                   ).toList();
//
//           },
//     );
//     chatRoomList.value = tempChatRoom
//         .where(
//         (e)=> e.id!.contains(
//           auth.currentUser!.uid,
//         ),
//     ).toList();
// print( chatRoomList);
//   }

Stream<List<UserModel> >getContacts(){
  return db.collection("users")
      .doc(auth.currentUser!.uid)
      .collection("contacts")
      .snapshots()
      .map(
            (snapshot) => snapshot.docs
                .map(
                (doc) => UserModel.fromJson(doc.data()),
            ).toList(),
          );
}
}
