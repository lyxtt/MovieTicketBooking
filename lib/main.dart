import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_home_admin.dart';
import 'package:movie_booking_ticket/dat_ve/page_home.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: [
              PhoneProviderConfiguration()
            ],
          );
        }
        if(FirebaseAuth.instance.currentUser!.phoneNumber! == "+84111111111" || FirebaseAuth.instance.currentUser!.phoneNumber! == "+84375373230")
          return PageHomeAdmin();
        else
          return PageHome();
      },
    );
  }
}