import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:majoni_sanchay/services/auth_service.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController passwordControl = TextEditingController();

  String validPass(value) {
    if (value.isEmpty) {
      return 'Required *';
    } else if (value.length < 6) {
      return 'Enter atleast 6 characters';
    } else if (value.length > 15) {
      return 'Can\'t be more than 15 characters';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.all(26.0),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome To Majoni Sanchay',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[900],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 18,
                  ),
                  child: TextFormField(
                    //onSaved: (input) => {_email = input},
                    //initialValue: 'Email',
                    controller: emailControl,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        size: 20,
                      ),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required *'),
                      EmailValidator(errorText: 'Not a valid email')
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 18,
                  ),
                  child: TextFormField(
                    controller: passwordControl,
                    obscureText: true,
                    //keyboardType: TextInputType.visiblePassword,
                    //initialValue: 'Password',
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.keyboard,
                        size: 20,
                      ),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: validPass,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 18,
                  ),
                  child: OutlineButton(
                    onPressed: () {
                      context.read<AuthServices>().signIn(
                            email: emailControl.text.trim(),
                            password: passwordControl.text.trim(),
                          );
                    },
                    child: Text(
                      'Login',
                    ),
                    highlightedBorderColor: Colors.amberAccent[400],
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                // Text(
                //   ,
                //   style: TextStyle(
                //     color: Colors.red,
                //     fontSize: 15.0,
                //   ),
                //)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
