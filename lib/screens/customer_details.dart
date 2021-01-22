import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:majoni_sanchay/screens/home.dart';

class CustomerDetails extends StatefulWidget {
  final DocumentSnapshot id;
  CustomerDetails(this.id);
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final TextEditingController inputControl = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Map<String, dynamic> get doc {
    return widget.id.data();
  }

  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  formatDate() {
    Timestamp timestamp = doc['date'];
    return DateTime.parse(timestamp.toDate().toString());
  }

  Future<void> updateMoney() async {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.id.id)
          .update({
            'totalAmount': doc['totalAmount'] + int.parse(inputControl.text)
          })
          .then((value) => print('something'))
          .catchError((error) => print("Failed to update user: $error"));

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Home(
          title: 'Home',
        );
      }));
    } catch (e) {
      print('error' + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          title: Text('Customer Details'),
        ),
        body: Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.amber[200]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Text('Customer\'s Name: ${doc['name']}'),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.amber[100],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.amber[200]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Text(
                            'Account Number: ${doc['account']} ${doc['isActive'] ? 'Active' : 'Inactive'}'),
                      ),
                    ),
                  ),

                  Divider(
                    height: 1,
                    color: Colors.amber[100],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.amber[200]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Text('Sanchay Type: ${doc['payType']}'),
                      ),
                    ),
                  ),
                  // Divider(
                  //   height: 1,
                  //   color: Colors.amber[100],
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(color: Colors.amber[200]),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 50,
                  //     child: Center(
                  //       child: Text('A/C Created at: ${formatDate()}'),
                  //     ),
                  //   ),
                  // ),
                  Divider(
                    height: 1,
                    color: Colors.amber[100],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.amber[200]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Text('Total Balance: ${doc['totalAmount']}'),
                      ),
                    ),
                  ),
                  Divider(
                    height: 3,
                    color: Colors.amber[100],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.amber[200]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          controller: inputControl,

                          keyboardType: TextInputType.number,
                          //textAlign: TextAlign.center,
                          //initialValue: 'Password',
                          decoration: InputDecoration(
                            labelText: 'amount',
                            border: OutlineInputBorder(),
                          ),
                          validator: RequiredValidator(errorText: 'required*'),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.amber[100],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.amber[200]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: FlatButton(
                          minWidth: MediaQuery.of(context).size.width - 2,
                          child: Text('Click here to Deposit'),
                          onPressed: updateMoney,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//   final DocumentSnapshot id;
//   CustomerDetails(this.id);
//   final TextEditingController inputControl = TextEditingController();

//   Map<String, dynamic> get doc {
//     return id.data();
//   }

//   final CollectionReference user =
//       FirebaseFirestore.instance.collection('users');

//   formatDate() {
//     Timestamp timestamp = doc['date'];
//     return DateTime.parse(timestamp.toDate().toString());
//   }

//   Future<void> updateMoney() async {
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(id.id)
//         .update({'totalAmount': 1})
//         .then((value) => print('something'))
//         .catchError((error) => print("Failed to update user: $error"));
//     ;
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(doc);

//     //final List<String> colorCodes = <String>['name'];
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.amber[100],
//         appBar: AppBar(
//           title: Text('Customer Details'),
//         ),
//         body: Center(
//           child: Container(
//             child: Padding(
//               padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(color: Colors.amber[200]),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: Center(
//                         child: Text('Customer\'s Name: ${doc['name']}'),
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 1,
//                     color: Colors.amber[100],
//                   ),
//                   Container(
//                     decoration: BoxDecoration(color: Colors.amber[200]),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: Center(
//                         child: Text(
//                             'Account Number: ${doc['account']} ${doc['isActive'] ? 'Active' : 'Inactive'}'),
//                       ),
//                     ),
//                   ),

//                   Divider(
//                     height: 1,
//                     color: Colors.amber[100],
//                   ),
//                   Container(
//                     decoration: BoxDecoration(color: Colors.amber[200]),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: Center(
//                         child: Text('Sanchay Type: ${doc['payType']}'),
//                       ),
//                     ),
//                   ),
//                   // Divider(
//                   //   height: 1,
//                   //   color: Colors.amber[100],
//                   // ),
//                   // Container(
//                   //   decoration: BoxDecoration(color: Colors.amber[200]),
//                   //   child: SizedBox(
//                   //     width: MediaQuery.of(context).size.width,
//                   //     height: 50,
//                   //     child: Center(
//                   //       child: Text('A/C Created at: ${formatDate()}'),
//                   //     ),
//                   //   ),
//                   // ),
//                   Divider(
//                     height: 1,
//                     color: Colors.amber[100],
//                   ),
//                   Container(
//                     decoration: BoxDecoration(color: Colors.amber[200]),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: Center(
//                         child: Text('Total Balance: ${doc['totalAmount']}'),
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 1,
//                     color: Colors.amber[100],
//                   ),
//                   Container(
//                     decoration: BoxDecoration(color: Colors.amber[200]),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: Form(
//                         child: TextFormField(
//                           controller: inputControl,
//                           obscureText: true,
//                           keyboardType: TextInputType.number,
//                           //initialValue: 'Password',
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.keyboard,
//                               size: 20,
//                             ),
//                             labelText: 'Password',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: RequiredValidator(errorText: 'required*'),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 1,
//                     color: Colors.amber[100],
//                   ),
//                   Container(
//                     decoration: BoxDecoration(color: Colors.amber[200]),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: Center(
//                         child: FlatButton(
//                           minWidth: MediaQuery.of(context).size.width - 2,
//                           child: Text('Click here to Deposit'),
//                           onPressed: updateMoney,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
