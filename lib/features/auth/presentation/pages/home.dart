import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('User Phone Number: ${user?.phoneNumber}')),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => signOut()),
        child: const Icon(Icons.logout),
      ),
    );
    
  }
}
