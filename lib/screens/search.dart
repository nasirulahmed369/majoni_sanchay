import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:majoni_sanchay/screens/customer_details.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  QuerySnapshot snapshots;
  TextEditingController queryString = TextEditingController();
  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    Widget searchData() {
      return ListView.builder(
        itemCount: snapshots.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 25.0,
              ),
              title: Text(
                '${snapshots.docs[index].data()['name']}',
                style: TextStyle(),
              ),
              subtitle: Text(
                  'Account Number: ${snapshots.docs[index].data()['account']}'),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CustomerDetails(snapshots.docs[index])))
              },
            ),
          );
        },
      );
    }
    // Default Widger

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            queryString.clear();
            this.setState(() {
              isAvailable = false;
            });
          },
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              controller: queryString,
              decoration: InputDecoration(
                  hintText: 'Enter a Account Number',
                  hintStyle: TextStyle(color: Colors.black)),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ]),
          actions: [
            GetBuilder<Data>(
              init: Data(),
              builder: (value) {
                return IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    value.query(queryString.text).then((val) {
                      snapshots = val;
                      setState(() {
                        isAvailable = true;
                      });
                    });
                  },
                );
              },
            )
          ],
        ),
        body: isAvailable
            ? searchData()
            : Container(
                child: Center(
                  child: Text('Enter account number to search'),
                ),
              ));
  }
}

class Data extends GetxController {
  Future getDataFromCollection(String collection) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snap = await firestore.collection(collection).get();
    return snap.docs;
  }

  Future query(String number) async {
    return FirebaseFirestore.instance
        .collection('agents')
        .doc((FirebaseAuth.instance.currentUser.uid))
        .collection('customers')
        .where('account', isEqualTo: number)
        .get();
  }
}
