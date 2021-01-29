import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchCustomer extends StatefulWidget {
  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController query = TextEditingController();

  int accountNo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Listen to Textfield
    query.addListener(getSearchValue);
  }

  getSearchValue() {
    print(query.text);
  }

  //Dispose all the function after moved to other page
  @override
  void dispose() {
    query.removeListener(getSearchValue);
    query.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  String validAccount(value) {
    if (value.isEmpty) {
      return 'Please a valid account Number';
    } else if (value.length < 10) {
      return "Account number should be at least 10";
    }
  }

  //final User user = FirebaseAuth.instance.currentUser();
  //final uid = user.uid;
  // Stream<QuerySnapshot> getCustomers(BuildContext context) async* {
  //   User user = FirebaseAuth.instance.currentUser;
  //   final uid = user.uid;
  //   //Yeild*
  //   // final getData =
  //   yield* FirebaseFirestore.instance
  //       .collection('agents')
  //       .doc(uid)
  //       .collection('customers')
  //       .where('account', isEqualTo: '${int.parse(query.text)}')
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    final firbaseUser = context.watch<User>();
    final db = FirebaseFirestore.instance
        .collection('agents')
        .doc(firbaseUser.uid)
        .collection('customers')
        .where('account', isEqualTo: accountNo);

    //getDatafromFirebase() {}

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Search Customer'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Container(
                child: TextFormField(
                  //controller: query,
                  onChanged: (val) => this.setState(() {
                    accountNo = int.parse(val);
                  }),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => query.clear(),
                    ),
                    hintText: 'Search a Account Number',
                    hintStyle: TextStyle(),
                  ),
                  validator: validAccount,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: StreamBuilder<QuerySnapshot>(
                stream: db.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // if (snapshot.hasError) {
                  //   return Text('Something went wrong');
                  // }

                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       strokeWidth: 5.0,
                  //     ),
                  //   );
                  // }
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
                            title: Text('${doc.data()['name']}'),
                            subtitle:
                                Text('Account No. ${doc.data()['account']}'),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  //return //CustomerDetails(doc);
                                }),
                              )
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                // stream: getCustomers(context),
                // builder: (context, snapshot) {
                //   return ListView.builder(
                //       itemCount: snapshot.data.documents.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return UserList(index);
                //       });
                // },
              ),
            ),
            // ListView()
          ],
        ),
      ),
    );
  }
}

// class Data extends GetxController {
//   String uid;
//   Data(this.uid);
//   Future getDataFromCollection(String collection) async {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//     QuerySnapshot snap = await firestore.collection(collection).get();
//     return snap.docs;
//   }

//   Future query(String query) {
//     return FirebaseFirestore.instance
//         .collection('agents')
//         .doc(uid)
//         .collection('customers')
//         .where('account', isEqualTo: int.parse(query))
//         .get();
//   }
// }
