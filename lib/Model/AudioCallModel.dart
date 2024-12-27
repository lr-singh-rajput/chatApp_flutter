class AudioCallModel {
  String? id;
  String? callerName;
  String? callerPic;
  String? callerEmail;
  String? callerUid;
  String? receiverName;
  String? receiverPic;
  String? receiverUid;
  String? receiverEmail;
  String? status;

  AudioCallModel({
      this.id, 
      this.callerName, 
      this.callerPic, 
      this.callerEmail, 
      this.callerUid, 
      this.receiverName, 
      this.receiverPic, 
      this.receiverUid, 
      this.receiverEmail, 
      this.status,});

  AudioCallModel.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    callerName = json['callerName'];
    callerPic = json['callerPic'];
    callerEmail = json['callerEmail'];
    callerUid = json['callerUid'];
    receiverName = json['receiverName'];
    receiverPic = json['receiverPic'];
    receiverUid = json['receiverUid'];
    receiverEmail = json['receiverEmail'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['callerName'] = callerName;
    map['callerPic'] = callerPic;
    map['callerEmail'] = callerEmail;
    map['callerUid'] = callerUid;
    map['receiverName'] = receiverName;
    map['receiverPic'] = receiverPic;
    map['receiverUid'] = receiverUid;
    map['receiverEmail'] = receiverEmail;
    map['status'] = status;
    return map;
  }

}