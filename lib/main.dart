import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majoni_sanchay/screens/home.dart';
import 'package:majoni_sanchay/screens/admin_panel.dart';
import 'package:majoni_sanchay/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:majoni_sanchay/services/auth_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (_) => AuthServices(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthServices>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Majoni Sanchay',
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firbaseUser = context.watch<User>();

    if (firbaseUser != null) {
      return firbaseUser.uid == 'PblGdd1mXzQGDUnJNszWq1aGpYp1'
          ? AdminPanel()
          : Home(title: 'dashboard');
    }
    return Login();
  }
}
