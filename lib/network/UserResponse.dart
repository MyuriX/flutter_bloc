
import 'package:flutterbloc/network/ModelWrapper.dart';

class UserResponse {
  List<User> temp;
  UserResponse({this.temp});
  UserResponse.fromJson( dynamic json) {
    temp = new List<User>();
    json.forEach((v){
      temp.add(new User.fromJson(v));
    });
  }
}

class User {
  String login;
  String type;

  User({
    this.login,
    this.type,
  });

  User.fromJson(Map<String , dynamic> json){
    login = json['login'];
    type = json['type'];
  }
}