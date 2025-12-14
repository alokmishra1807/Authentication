// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth/features/auth/presentation/widgets/gradient_button.dart';
import 'package:auth/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:svg_flutter/svg.dart';

class Otp extends StatefulWidget {
  final String vid;
  final String number;
  const Otp({Key? key, required this.vid, required this.number})
    : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var code = '';

  login() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid,
      smsCode: code,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
        Get.offAll(Scrapper());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error', e.code);
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  Image.asset('assets/images/otp.png'),
                  
                  const Text(
                    'Verify Otp',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  const SizedBox(height: 20),
            
                  Text(
                    'Enter OTP sent to +91 ${widget.number}',
            
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      length: 6,
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  GradientButton(text: 'Verify and Proceed', onPressed:login),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
