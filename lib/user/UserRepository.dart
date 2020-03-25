
import 'package:flutterbloc/network/UserResponse.dart';
import 'package:flutterbloc/user/UserDao.dart';

class UserRepository{
  final userDao = new UserDao();

  Future<List<UserResponse>> getUserList(){
    userDao.fetchUserList();
  }

}