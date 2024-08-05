import 'dart:js_interop';

class UserModel{
  final String? id;
  final String name;
  final String mail;
  final String password;
  const UserModel({
    this.id,
    required this.mail,
    required this.password,
    required this.name,
});

  toJson(){
    return{
      "name":name,
      "mail":mail,
      "password":password,
    };
  }
}
