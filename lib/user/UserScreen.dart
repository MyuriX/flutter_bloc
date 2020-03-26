import 'package:flutter/material.dart';
import 'package:flutterbloc/network/UserResponse.dart';
import 'package:flutterbloc/widgets/ErrorMessageWidget.dart';
import 'package:flutterbloc/widgets/LoadMoreWidget.dart';
import 'package:flutterbloc/widgets/LoadingWidget.dart';
import 'package:flutterbloc/widgets/NoDataWidget.dart';
import 'package:http/http.dart' as http;
import '../user/UserBloc.dart';



class UserScreen extends StatefulWidget {
  @override
  UserScreenState createState() {
    return UserScreenState();
  }
}

class UserScreenState extends State<UserScreen> {
  final userBloc = Userbloc();

  @override
  void initState() {
    super.initState();
    userBloc.getUsers();
  }

  @override
  void dispose() {
    userBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home screen'),
      ),
      body: getUserList(),
    );
  }

  Widget getUserList(){
    return StreamBuilder(
      stream: userBloc.userList,
      builder: (context, AsyncSnapshot<List<UserResponse>> snapshot) {
        print('Has error: ${snapshot.hasError}');
        print('Has data: ${snapshot.hasData}');
        print('Snapshot Data: ${snapshot.data}');
        print('Connection State: ${snapshot.connectionState}');

        if (snapshot.hasData) {
          print('Inside hasData');
          if (snapshot.data == null || snapshot.data.length == 0) {
            print('Inside no Data');
            return _buildNoDataWidget();
          } else {
            return _userListWidget(snapshot);
          }
        } else if (snapshot.hasError) {
          print('Inside hasError');
          return _buildErrorWidget(snapshot.error);
        } else {
          print('Inside progressbar');
          return _buildLoadingWidget();
        }
      },
    );
  }
  Widget _buildNoDataWidget(){
    return NoDataWidget();
  }

  Widget _buildLoadingWidget(){
     return LoadingWidget();
  }


  Widget _userListWidget(AsyncSnapshot<List<UserResponse>> snapshot){
    //List<UserResponse> list = snapshot.
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context,index){
        return Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(snapshot.data[index].temp[index].login != null ? snapshot.data[index].temp[index].login : 'Empty'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(snapshot.data[index].temp[index].type != null ? snapshot.data[index].temp[index].type : 'Empty' ),
                    )
                  ],
                ),
              ),
            );

    }
    );
  }

  Widget _buildErrorWidget(Object error) {
    return ErrorMessageWidget(error: error);
  }
}


