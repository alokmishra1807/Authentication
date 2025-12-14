import 'package:auth/features/auth/presentation/pages/otp.dart';
import 'package:auth/features/auth/presentation/widgets/gradient_button.dart';
import 'package:auth/features/auth/presentation/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

class Loginwithphone extends StatefulWidget {
  const Loginwithphone({super.key});

  @override
  State<Loginwithphone> createState() => _LoginwithphoneState();
}

class _LoginwithphoneState extends State<Loginwithphone> {
  final phoneNumberController = TextEditingController();

  sendCode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumberController.text,

        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('error', e.toString());
        },
        codeSent: (String vid, int? token) {
          Get.to(Otp(vid: vid,number: phoneNumberController.text,));
        },
        codeAutoRetrievalTimeout: (vid) {},
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error', e.code);
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 14,),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  Image.asset('assets/images/mobile.png'),
                  
                  const Text(
                    'Your Phone !',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  const SizedBox(height: 20),
            
                  Text(
                    'Enter your Phone Number and we will send you an OTP to continue.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  LoginField(
                    hintText: 'Phone Number',
                    controller: phoneNumberController,
                  ),
                  const SizedBox(height: 20),
                  GradientButton(text: 'Send Otp', onPressed: sendCode),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
