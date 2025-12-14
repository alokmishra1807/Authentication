import 'package:auth/core/design/pallete.dart';
import 'package:auth/features/auth/presentation/pages/home.dart';
import 'package:auth/features/auth/presentation/pages/login_screen.dart';
import 'package:auth/features/auth/presentation/pages/verify_email.dart';
import 'package:auth/features/home/presentation/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: const Scrapper(),
    );
  }
}

class Scrapper extends StatelessWidget {
  const Scrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;

            if (user.emailVerified) {
              return const Homepage();
            }
            if (user.email == null || user.email!.isEmpty) {
              return const Home();
            }
            return VerifyEmail();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
