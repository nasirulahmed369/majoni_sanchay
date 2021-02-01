import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:majoni_sanchay/screens/search.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user = FirebaseAuth.instance.currentUser;
  // ignore: missing_return
  String validSearch(value) {
    if (value.isEmpty) {
      return 'Required *';
    } else if (value.length <= 10) {
      return 'Enter a valid account number';
    }
  }

  String query = '';

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<CustomerModel>>.value(
    //   value: DatabaseService().users,
    //   child: UserList(),
    //return UserList();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              )
            ],
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: RaisedButton(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Search()
                                  //SearchCustomer()
                                  //UserList(query)
                                  ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 55,
                                width: 55,
                                color: Colors.transparent,
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Sanchay'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // SizedBox(
                    //   child: RaisedButton(
                    //     elevation: 10,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.zero,
                    //       //side: BorderSide(color: Colors.red),
                    //     ),
                    //     color: Colors.white,
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => AgentDetails()));
                    //     },
                    //     child: Padding(
                    //       padding: EdgeInsets.all(10),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: <Widget>[
                    //           Container(
                    //             height: 55,
                    //             width: 55,
                    //             color: Colors.transparent,
                    //             child: Icon(
                    //               Icons.settings,
                    //               size: 30,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //           Text(
                    //             'Settings'.toUpperCase(),
                    //             style: TextStyle(
                    //               fontSize: 20,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
