class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.profileImage,
      this.phoneNumber,
      this.about,
      this.createdAt,
      this.lastOnlineStatus,
      this.status,
      this.role,
      });

  //Update fromJson method to match key names exacatly
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    about = json['about'];
    createdAt = json['createdAt'];
    lastOnlineStatus = json['lastOnlineStatus'];
    status = json['status'];
    role = json['role'];
  }
  // Updated toJson method to match key names exactly
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['profileImage'] = profileImage;
    _data['phoneNumber'] = phoneNumber;
    _data['about'] = about;
    _data['createAt'] = createdAt;
    _data['lastOnlineStatus'] = lastOnlineStatus;
    _data['status'] = status;
    _data['role'] = role;

    return _data;
  }
}
