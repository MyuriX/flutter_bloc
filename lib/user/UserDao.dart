import 'dart:convert';

import 'package:flutterbloc/network/BaseDio.dart';
import 'package:flutterbloc/network/UserResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class UserDao with BaseDio{

  Future<List<UserResponse>> fetchUserList() async{
    Dio dio = await getBaseDio();
   UserResponse userResponse = UserResponse();
   List<UserResponse> list = [];

    Response<List> response = await dio.get("users") ;
    if(response.statusCode == 200){
      print('Api call${response.data.runtimeType}');
      print("DAO:::API sucess");
      for(int i =0;i<response.data.length;i++){
        userResponse = UserResponse.fromJson(response.data);
        list.add(userResponse);
      }
    }else{
      print('Failed to load');
    }
    return list;
  }

}