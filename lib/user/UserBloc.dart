
import 'dart:async';

import 'package:flutterbloc/network/UserResponse.dart';
import 'package:flutterbloc/user/UserRepository.dart';
import 'package:rxdart/rxdart.dart';

class Userbloc{
  Userbloc();
  int totalCount;
  int listCount;

  final _userRepository = UserRepository();
  final _userListController = StreamController<List<UserResponse>>.broadcast();
  final _isLoadMore = BehaviorSubject<bool>();

  get userList => _userListController.stream;
  get loadMore => _isLoadMore.stream;

  Function(bool) get showProgressBar{
    _isLoadMore.sink.add;
  }

  getUsers() async{
      List<UserResponse> userResponse = await _userRepository.getUserList();
        _userListController.sink.add(userResponse);
        print('Bloc::API sucess');
    }

    dispose(){
      _isLoadMore.close();
      _isLoadMore.drain();
      _userListController.close();

    }

}
