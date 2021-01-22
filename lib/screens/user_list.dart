import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majoni_sanchay/screens/customer_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  //final users = Provider.of<List<CustomerModel>>(context);
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  // print(usersList);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              iconSize: 20,
              padding: EdgeInsets.all(0),
              tooltip: 'Log Out',
              icon: Icon(Icons.person_add_alt_1_rounded),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
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
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                ),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot doc) {
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 25.0,
                      ),
                      title: Text(doc.data()['name']),
                      subtitle: Text('Account No. ${doc.data()['account']}'),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CustomerDetails(doc);
                          }),
                        )
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
