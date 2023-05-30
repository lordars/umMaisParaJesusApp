class LoginModel {
  String? name = "";
  String? email = "";
  String? password = "";
  bool? keepOn = false;

  LoginModel({this.name, this.email, this.password, this.keepOn});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    email = json['email'];
    password = json['password'];
    keepOn = json['keepOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['keepOn'] = keepOn;
    return data;
  }

  @override
  String toString() {
    return "Name: ${name!}\n Email: ${email!}\n Password: ${password!}";
  }
}
