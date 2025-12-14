import 'package:auth/core/design/pallete.dart';
import 'package:auth/features/auth/presentation/pages/login_screen.dart';
import 'package:auth/features/auth/presentation/pages/verify_email.dart';
import 'package:auth/features/auth/presentation/widgets/gradient_button.dart';
import 'package:auth/features/auth/presentation/widgets/login_field.dart';
import 'package:auth/features/auth/presentation/widgets/social_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => const SignupScreen());
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAll(VerifyEmail());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Sign up failed',
        e.message ?? e.code,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Sign up failed',
        e.toString(),
        margin: const EdgeInsets.all(16),
      );
    } 
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                const Text(
                  'Sign Up.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                const SizedBox(height: 50),
                SocialButton(
                  iconPath: 'assets/svgs/g_logo.svg',
                  label: 'Continue with Google',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                
                const SizedBox(height: 15),
                const Text('or', style: TextStyle(fontSize: 17)),
                const SizedBox(height: 15),
                LoginField(hintText: 'Email', controller: emailController),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                GradientButton(text: 'Sign Up', onPressed: signUp),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Get.offAll(LoginScreen());
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Pallete.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
