import 'package:auth/core/design/pallete.dart';
import 'package:auth/features/auth/presentation/pages/forget_password.dart';
import 'package:auth/features/auth/presentation/pages/loginwithphone.dart';
import 'package:auth/features/auth/presentation/pages/signup_screen.dart';
import 'package:auth/features/auth/presentation/widgets/gradient_button.dart';
import 'package:auth/features/auth/presentation/widgets/login_field.dart';
import 'package:auth/features/auth/presentation/widgets/social_button.dart';
import 'package:auth/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> signIn() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAll(const Scrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login failed',
        e.message ?? e.code,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Login failed',
        e.toString(),
        margin: const EdgeInsets.all(16),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  final GoogleSignIn signInWith = GoogleSignIn.instance;

  Future<void> signInWithGoogle() async {
    try {
      await signInWith.initialize(
        serverClientId:
            '522368857810-pq07h6jvnf2m2i0gi112i7tcuskb78fc.apps.googleusercontent.com',
      );

      final account = await signInWith.authenticate();

      final auth = account.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Get.offAll(const Scrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Google Sign-In Failed',
        e.message ?? e.code,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Google Sign-In Failed',
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
                  'Sign in.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                const SizedBox(height: 50),
                SocialButton(
                  iconPath: 'assets/svgs/g_logo.svg',
                  label: 'Continue with Google',
                  onPressed: () {
                    signInWithGoogle();
                  },
                ),
    
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
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ForgetPassword(),
                        ),
                      );
                    },
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 10),
                GradientButton(text: 'Sign In', onPressed: signIn),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(SignupScreen.route());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: const [
                        TextSpan(
                          text: 'Sign Up',
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
                GestureDetector(
                  onTap: () {
                    Get.off(Loginwithphone());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Login With ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: const [
                        TextSpan(
                          text: 'Phone Number',
                          style: TextStyle(
                            color: Pallete.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
