class UserLoginReq {
  String? username;
  String? password;
  String? newPassword;

  UserLoginReq({this.username, this.password, this.newPassword});

  UserLoginReq.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (username != null) {
      data['username'] = username;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (newPassword != null) {
      data['newPassword'] = newPassword;
    }
    return data;
  }
}
