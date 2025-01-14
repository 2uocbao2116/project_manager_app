class UserData {
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? token;
  String? password;
  List? links;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.token,
    this.password,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    token = json['token'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (firstName != null) {
      data['first_name'] = firstName;
    }
    if (lastName != null) {
      data['last_name'] = lastName;
    }
    if (phoneNumber != null) {
      data['phone_number'] = phoneNumber;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (token != null) {
      data['token'] = token;
    }
    if (password != null) {
      data['password'] = password;
    }
    // if (links != null) {
    //   data['links'] = links?.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
