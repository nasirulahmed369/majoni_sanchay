import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:majoni_sanchay/screens/Customer_register.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  User user = FirebaseAuth.instance.currentUser;
  String filePath;
  String currentProcess;

  // Todo Access directory

  // Todo-- create a file

  // todo Get List of items from firebase

  // handlepress() async {
  //   List<List<dynamic>> rows = List<List<dynamic>>();

  //   // final db = FirebaseFirestore.instance
  //   //     .collection('agents')
  //   //     .doc('Es2BgXunj4PDbgX56VIK4Z08lle2')
  //   //     .collection('customers')
  //   //     .get();

  //   rows.add([
  //     "Name",
  //     "father\'s Name",
  //     "Adress",
  //     "Account Number",
  //     "Agent\'s name",
  //     "Installment",
  //     "Phone number",
  //     "Start Date",
  //     "Sanchay Type",
  //     "Tenure/Duration",
  //     "Total amount",
  //     "End Date"
  //   ]);

  //   final db = FirebaseFirestore.instance
  //       .collection('agents')
  //       .doc('Iwd5PEpumvdwJyx89HGLsrOVrGg2')
  //       .collection('customers')
  //       //.doc()
  //       .get();

  //   if (db != null) {
  //     db.then((QuerySnapshot snapshot) {
  //       snapshot.docs.map((doc) {
  //         List<dynamic> row = List<dynamic>();
  //         row.add([
  //           doc.data()['name'],
  //           doc.data()['fatheName'],
  //           doc.data()['address'],
  //           doc.data()['account'],
  //           doc.data()['agent'],
  //           doc.data()['installment'],
  //           doc.data()['phone'],
  //           doc.data()['startDate'],
  //           doc.data()['tenure'],
  //           doc.data()['totalAmount'],
  //         ]);
  //         rows.add(row);
  //         // print(snap.toString());
  //         print(rows);
  //       });
  //     });
  //   }

  //   // FirebaseFirestore.instance
  //   //     .collection('agents')
  //   //     .doc('Es2BgXunj4PDbgX56VIK4Z08lle2')
  //   //     .collection('customers')
  //   //     .get()
  //   //     .then((QuerySnapshot querySnapshot) {
  //   //   querySnapshot.docs.forEach((doc) {
  //   //     print(doc);
  //   //   });
  //   // });
  //   //print(rows);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text('Admin Panel'),
        actions: [
          IconButton(
            iconSize: 20,
            padding: EdgeInsets.all(0),
            tooltip: 'Log Out',
            icon: Icon(Icons.person),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                //Customer Registration page
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerRegister(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    'Add a Customer',
                    style: TextStyle(color: Colors.amber[900], fontSize: 20),
                  ),
                ),
              ),
              // RaisedButton(
              //   onPressed: ,
              //   child: Center(
              //     child: Text(
              //       'All Customers',
              //       style: TextStyle(color: Colors.amber[900], fontSize: 20),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// class Search extends SearchDelegate<String> {
//   // Future<List<DocumentSnapshot>> documentList() async =>{ (await FirebaseFirestore.instance
//   //       .collection("cases")
//   //       .doc()
//   //       .
//   //       // .collection(caseCategory)
//   //       // .where("caseNumber", isEqualTo: query)
//   //       // .getDocuments())
//   //       // .documents;

//   // }
//   final CollectionReference users =
//       FirebaseFirestore.instance.collection('users');

//   // Future<void> getUsers = users.get()
//   final account = ['1234', '321'];
//   final recentQueries = ['nasir', 'risan'];
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {},
//       )
//     ];
//   }

//   @override
//   Widget buildResults(BuildContext context) {}
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggested = query.isEmpty ? recentQueries : account;

//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.blue,
//           radius: 25.0,
//         ),
//         title: Text(suggested[index]),
//         subtitle: Text(''),
//         onTap: () => {},
//       ),
//       itemCount: suggested.length,
//     );
//   }
// }

//print(rows);
//final cloud = db.get();

// if (db != null) {
//   // for (int i = 0; i < db.data.length; i++) {
//   //   List<dynamic> row = List<dynamic>();
//   //   //print(db.data()['customers'][i]['name']);
//   //   row.add([
//   //     db.data()[i]['name'],
//   //   ]);
//   // }

// }

// db.get().then((QuerySnapshot snapshot) {
//   snapshot.docs.map((doc) {
//     List<dynamic> row = List<dynamic>();
//     row.add([
//       doc['name'],
//       doc['fatheName'],
//       doc['address'],
//       doc['account'],
//       doc['agent'],
//       doc['installment'],
//       doc['phone'],
//       doc['startDate'],
//       doc['tenure'],
//       doc['totalAmount'],
//     ]);
//     rows.add(row);
//     print(row);
//   });
// });
