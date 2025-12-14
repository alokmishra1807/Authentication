import 'package:auth/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    super.initState();
    sendVerifyLink();
  }

  Future<void> sendVerifyLink() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar(
        'No user',
        'Please sign in again.',
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      await user.sendEmailVerification();
      Get.snackbar(
        'Link Sent',
        'A verification email has been sent to your email address.',
        margin: const EdgeInsets.all(16),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Could not send link',
        e.message ?? e.code,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Could not send link',
        e.toString(),
        margin: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> reloadUser() async {
    await FirebaseAuth.instance.currentUser!.reload().then(
      (value) => {Get.offAll(Scrapper())},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verify your email',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'A verification email has been sent. Please click the link in your inbox, then tap refresh.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // ElevatedButton(
              //   onPressed: sendVerifyLink,
              //   child:
              //        const Text('Resend verification email'),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => reloadUser()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
