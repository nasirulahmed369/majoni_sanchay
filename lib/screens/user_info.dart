import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  Query users = FirebaseFirestore.instance.collection('users');
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('hello'),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.person),
              onPressed: () {},
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return ListTile(
                  subtitle: Text(document.data()['name']),
                  title: Text(document.data()['account'].toString()),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
