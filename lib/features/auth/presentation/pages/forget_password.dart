import 'package:auth/features/auth/presentation/pages/login_screen.dart';
import 'package:auth/features/auth/presentation/widgets/gradient_button.dart';
import 'package:auth/features/auth/presentation/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
 

  Future<void> sendResetLink() async {
    
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Get.snackbar(
        'Reset link sent',
        'Check your email to reset your password.',
        margin: const EdgeInsets.all(16),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Failed to send reset link',
        e.message ?? e.code,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Failed to send reset link',
        e.toString(),
        margin: const EdgeInsets.all(16),
      );
    } 
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Forget Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Enter your email and we will send you a password reset link.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              LoginField(hintText: 'Email', controller: emailController),
              const SizedBox(height: 20),
              GradientButton(
                text: 'Send reset link',
                onPressed: sendResetLink,
                
              ),
              TextButton(
                onPressed: () =>
                  Get.offAll(LoginScreen()),
                child: const Text('Back to Login'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
