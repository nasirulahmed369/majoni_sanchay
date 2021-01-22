import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:majoni_sanchay/screens/user_list.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey formkey = GlobalKey();
  User user = FirebaseAuth.instance.currentUser;
  // ignore: missing_return
  String validAccount(value) {
    if (value.isEmpty) {
      return 'Required *';
    }
  }

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<CustomerModel>>.value(
    //   value: DatabaseService().users,
    //   child: UserList(),
    return UserList();
  }
}
