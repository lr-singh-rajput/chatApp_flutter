// "id":"",
// "name":"",
// "description":"",
// "profileUrl":"",
// "members":[],
// "messages":[],
// "createAt":"",
// "createdBy":"",
// "status":"",
// "lastMessage":"",
// "lastMessageTime":"",
// "lastMessageBy":"",
// "unReadCount":0,
// "timeStamp":"",

import 'package:chatapp/Model/UserModel.dart';

class GroupModel {
  String? id;
  String? name;
  String? description;
  String? profileUrl;
  List<UserModel>? members;
  String? createAt;
  String? createdBy;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageBy;
  int? unReadCount;
  String? timeStamp;

  GroupModel({
    this.id,
    this.name,
    this.description,
    this.profileUrl,
    this.members,
    this.createAt,
    this.createdBy,
    this.status,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageBy,
    this.unReadCount,
    this.timeStamp,
  });

  GroupModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["profileUrl"] is String) {
      profileUrl = json["profileUrl"];
    }
    // if (json["members"] is Map) {
    //   json["members"] == null ? null : UserModel.fromJson(json["members"]);
    // }

    if(json["members"] != null){
      members = List<UserModel>.from(
        json["members"].map((memberJson) => UserModel.fromJson(memberJson)),
      );
    }else{
      members= [];
    }

    if (json["createAt"] is String) {
      createAt = json["createAt"];
    }
    if (json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["lastMessage"] is String) {
      lastMessage = json["lastMessage"];
    }
    if (json["lastMessageTime"] is String) {
      lastMessageTime = json["lastMessageTime"];
    }
    if (json["lastMessageBy"] is String) {
      lastMessageBy = json["lastMessageBy"];
    }
    if (json["unReadCount"] is int) {
      unReadCount = json["unReadCount"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
  }

  Map<String,dynamic> toJson(){

  final Map<String, dynamic>_data = <String, dynamic>{};
  _data["id"] =id;
  _data["name"] =name;
  _data["description"] =description;
  _data["profileUrl"] =id;
  _data["id"] =profileUrl;
  if(members  != null){
    _data["members"]=members;
  }
  _data["createAt"] =createAt;
  _data["createdBy"] =createdBy;
  _data["status"] =status;
  _data["lastMessage"] =lastMessage;
  _data["lastMessageTime"] =lastMessageTime;
  _data["lastMessageBy"] =lastMessageBy;
  _data["unReadCount"] =unReadCount;
  _data["timeStamp"] =timeStamp;

  return _data;
  }

}
