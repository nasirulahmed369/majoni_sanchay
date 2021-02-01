import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:majoni_sanchay/screens/admin_panel.dart';

class CustomerRegister extends StatelessWidget {
  //final _formKey = new GlobalKey<FormState>();

  String agent1 = 'RLy8OMdxH3NHuBIbkP1s41nZX3I2';
  String agent2 = 'Qshwbh8fZPMgVdANlIKvBBT5wl83';
  String agent3 = '5Qdwqw8l2LRent6pqA7zIMLh3fI2';
  String agent4 = 'i3zReXU5BxWDuMq9QChvop6vpkM2';
  String agent5 = 'rtHJX7qmGfU6Y6U4MgTJEkh7riQ2';

  String _sanchayType = 'Daily';
  String _agent;

  TextEditingController _name = TextEditingController();
  TextEditingController _account = TextEditingController();
  TextEditingController _fatherName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _installment = TextEditingController();
  TextEditingController _tenure = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference db = FirebaseFirestore.instance.collection('agents');

    Future<void> onRegister() async {
      String month = ' months';
      // Call the user's CollectionReference to add a new user
      return db
          .doc(_agent)
          .collection('customers')
          .add({
            'name': _name.text.trim(),
            'account': _account.text.trim(),
            'fatheName': _fatherName.text.trim(),
            'address': _address.text.trim(),
            'phone': _phone.text.trim(),
            'installment': _installment.text.trim(),
            'tenure': _tenure.text.trim() + month,
            'sanchayType': _sanchayType,
            'agent': _agent,
            'startDate': DateTime.now(),
            'totalMoney': 0,
            'endDate': null,
          })
          .then((value) => {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AdminPanel()))
                  }
              //Show popup menu
              // (value) => AlertDialog(
              //   title: Text('AlertDialog Title'),
              //   content: SingleChildScrollView(
              //     child: ListBody(
              //       children: <Widget>[
              //         Text('User '),
              //         Text('Would you like to approve of this message?'),
              //       ],
              //     ),
              //   ),
              // ),
              )
          .catchError((error) {
            print("Failed to add user: $error");
          });
    }

    return KeyboardAvoider(
      child: Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              //key: _formKey,
              child: Column(
                children: [
                  //SizedBox(height: 10,),
                  TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _account,
                    decoration: InputDecoration(labelText: 'Account Number'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _fatherName,
                    decoration: InputDecoration(labelText: 'Father\'s name'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _address,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phone,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  DropdownButtonFormField<String>(
                    hint: Text('Select Agent'),
                    items: [
                      DropdownMenuItem(
                        value: 'agent1',
                        child: Text('Agent 1'),
                      ),
                      DropdownMenuItem(
                        value: 'agent2',
                        child: Text('Agent 2'),
                      ),
                      DropdownMenuItem(
                        value: 'agent3',
                        child: Text('Agent 3'),
                      ),
                      DropdownMenuItem(
                        value: 'agent4',
                        child: Text('Agent 4'),
                      ),
                      DropdownMenuItem(
                        value: 'agent5',
                        child: Text('Agent 5'),
                      )
                    ],
                    autofocus: false,
                    onChanged: (val) => {
                      if (val == 'agent1')
                        {_agent = agent1}
                      else if (val == 'agent2')
                        {_agent = agent2}
                      else if (val == 'agent3')
                        {_agent = agent3}
                      else if (val == 'agent4')
                        {_agent = agent4}
                      else if (val == 'agent5')
                        {_agent = agent5}
                    },
                  ),
                  DropdownButtonFormField<String>(
                    hint: Text('Sanchay Type'),
                    items: [
                      DropdownMenuItem(
                        value: 'Daily',
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: 'Weekly',
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: 'Monthly',
                        child: Text('Monthly'),
                      )
                    ],
                    autofocus: false,
                    onChanged: (val) => _sanchayType = val,
                  ),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _installment,
                    decoration: InputDecoration(labelText: 'Installment'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _tenure,
                    decoration: InputDecoration(labelText: 'Tenure'),
                  ),
                  RaisedButton(
                    child: Text('Add Customer'),
                    onPressed: onRegister,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class AgentRegister extends StatelessWidget {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Row(
//         children: <Widget>[
//           Flexible(
//             flex: 1,
//             child: Column(
//               children: <Widget>[
//                 Flexible(flex: 2, child: _buildPlaceholder(Colors.red)),
//                 Flexible(flex: 1, child: _buildPlaceholder(Colors.pink)),
//               ],
//             ),
//           ),
//           Flexible(
//             flex: 2,
//             child: Column(
//               children: <Widget>[
//                 Flexible(flex: 2, child: _buildForm(40, Colors.green)),
//                 Flexible(
//                   flex: 1,
//                   child: _buildPlaceholder(Colors.lightGreen),
//                 ),
//               ],
//             ),
//           ),
//           Flexible(
//             flex: 1,
//             child: Column(
//               children: <Widget>[
//                 Flexible(flex: 1, child: _buildPlaceholder(Colors.blue)),
//                 Flexible(flex: 2, child: _buildPlaceholder(Colors.lightBlue)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildForm(int rows, Color color) {
//     return Container(
//       color: color,
//       child: KeyboardAvoider(
//         autoScroll: true,
//         child: ListView.builder(
//           padding: EdgeInsets.zero,
//           controller: _scrollController,
//           itemCount: rows,
//           itemBuilder: (context, index) {
//             return Material(
//               child: TextFormField(
//                 initialValue: 'TextFormField ${index + 1}',
//                 decoration: InputDecoration(fillColor: color, filled: true),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPlaceholder(Color color) {
//     return Container(
//       color: color,
//       child: KeyboardAvoider(
//         child: Placeholder(),
//       ),
//     );
//   }
// }
