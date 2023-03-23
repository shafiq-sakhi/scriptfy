class UserModel {
  String? email;
  String? userId;
  String? phone;
  String? photoUrl;
  String? name;
  String? code;
  int? stars;

  UserModel({this.email, this.userId, this.phone, this.photoUrl, this.name,this.stars});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    userId = json['UserId'];
    phone = json['Phone'];
    photoUrl = json['PhotoUrl'];
    name = json['Name'];
    code = json['code'];
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['UserId'] = this.userId;
    data['Phone'] = this.phone;
    data['PhotoUrl'] = this.photoUrl;
    data['Name'] = this.name;
    data['code'] = this.code;
    data['stars'] = this.stars;
    return data;
  }
}
