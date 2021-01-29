import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:majoni_sanchay/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class CustomerDetails extends StatefulWidget {
  final DocumentSnapshot id;
  CustomerDetails(this.id);
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  //final TextEditingController inputControl = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String amount = '';
  Map<String, dynamic> get doc {
    return widget.id.data();
  }
  //User user = FirebaseAuth.instance.currentUser;

  formatDate() {
    Timestamp timestamp = doc['startDate'];
    return DateTime.parse(timestamp.toDate().toString());
  }

  // Future<void> updateMoney() async {
  //   try {
  //     FirebaseFirestore.instance
  //         .collection("users")
  //         .doc()
  //         .collection('customers')
  //         .doc(widget.id.)
  //         .update({
  //           'totalAmount': doc['totalAmount'] + int.parse(inputControl.text)
  //         })
  //         .then((value) => print('something'))
  //         .catchError((error) => print("Failed to update user: $error"));

  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return Home(
  //         title: 'Home',
  //       );
  //     }));
  //   } catch (e) {
  //     print('error' + e);
  //   }
  // }

  String validAmount(value) {
    final isDigitsOnly = int.tryParse(value);
    return isDigitsOnly == null ? 'Input needs to be digits only' : null;
  }

  @override
  Widget build(BuildContext context) {
    final firbaseUser = Provider.of<User>(context);
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
                        child: Text('Account Number: ${doc['account']}'),
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
                        child: Text('Sanchay Type: ${doc['sanchayType']}'),
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
                          //controller: inputControl,
                          onChanged: (val) => this.setState(() {
                            amount = val;
                          }),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),

                          decoration: InputDecoration(
                            labelText: 'amount',
                            border: OutlineInputBorder(),
                          ),
                          validator: validAmount,

                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
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
                          minWidth: MediaQuery.of(context).size.width - 10,
                          child: Text('Click here to Deposit'),
                          onPressed: () async {
                            final formState = _formkey.currentState;
                            if (formState.validate()) {
                              formState.save();
                              try {
                                FirebaseFirestore.instance
                                    .collection("agents")
                                    .doc(firbaseUser.uid)
                                    .collection('customers')
                                    .doc(widget.id.id)
                                    .update({
                                      'totalAmount':
                                          doc['totalAmount'] + int.parse(amount)
                                    })
                                    .then((value) => print('something'))
                                    .catchError((error) =>
                                        print("Failed to update user: $error"));

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Home(
                                    title: 'Home',
                                  );
                                }));
                              } catch (e) {
                                print('error' + e);
                              }
                            }
                          },
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
