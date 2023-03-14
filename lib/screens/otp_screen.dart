import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:project_hmc/firebase/firebase_auth.dart';
import 'package:project_hmc/screens/chat_screen.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late Timer _resendTimer;
  final bool _canResendOTP = true;
  final int _resendTimeout = 0;
  String? _otp;

  // void _handleResendOTP() {
  //   setState(() {
  //     _resendTimer = Timer(const Duration(seconds: 30), () {
  //       setState(() {
  //         _canResendOTP = true;
  //       });
  //     });
  //     _canResendOTP = false;
  //     _startResendTimer();
  //   });
  //   // Call the function to resend OTP here
  // }

  // void _startResendTimer() {
  //   // Set the resend timeout to 30 seconds
  //   _resendTimeout = 30;

  //   // Start the timer and update the timeout value every second
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       _resendTimeout--;

  //       // Cancel the timer when the timeout is reached
  //       if (_resendTimeout <= 0) {
  //         timer.cancel();
  //       }
  //     });
  //   });
  // }

  void navigate() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    _resendTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 35),
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 290,
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/reg.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 46),
                const Text(
                  "VERIFICATION",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 23),
                const Text(
                  "We will verify your phone number by sending an OTP code.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                OtpTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  numberOfFields: 6,
                  showCursor: false,
                  clearText: true,
                  borderColor: Colors.blue,
                  fieldWidth: 40,
                  showFieldAsBox: true,
                  borderWidth: 2.0,
                  /*onCodeChanged: (String verificationCode){
                          setState(() {
                            ((verificationCode.isEmpty))? _navigate=false : _navigate=true;
                          });
                        },*/
                  onSubmit: (String code) {
                    setState(() {
                      _otp = code;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextButton(
                    onPressed: null,
                    child: Text(_canResendOTP
                        ? "Resend Code"
                        : "Resend Code in $_resendTimeout seconds"),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 50,
                  width: 145,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_otp != null) {
                        await FirebaseAuthentication.verifyPhoneNumber(
                            verificationId: widget.verificationId,
                            smsCode: _otp!);
                      }
                      if (FirebaseAuthentication.isLoggedIn()) {
                        navigate();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      "VERIFY",
                      style: TextStyle(
                        fontSize: 20,
                      ),
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
