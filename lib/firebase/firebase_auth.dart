import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_hmc/screens/otp_screen.dart';

class FirebaseAuthentication {
  static late FirebaseAuth _auth; //FirebaseAuth instance

  static void initFirebaseAuth() {
    _auth = FirebaseAuth.instance;
  }

  static String get getUserUid {
    return _auth.currentUser!.uid;
  }

  static String get getUserName {
    return _auth.currentUser!.displayName.toString();
  }

  static Stream<User?> get getUserStream {
    return _auth.authStateChanges().map((User? user) {
      if (user == null) {
        return null;
      } else {
        return user;
      }
    });
  }

  static User? get getCurrentUser {
    return _auth.currentUser;
  }

  static bool isLoggedIn() {
    final User? user = _auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  static Future getOTPonPhoneNumber({
    required String number,
    required BuildContext context,
  }) async {
    String? userVerificationId;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        timeout: const Duration(seconds: 20),
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          userVerificationId = verificationId;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return OTPScreen(verificationId: verificationId);
          }));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      return userVerificationId ?? '';
    } catch (e) {
      debugPrint("error=================");
      rethrow;
    }
  }

  static Future verifyPhoneNumber(
      {required String verificationId, required String smsCode}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(phoneAuthCredential);
    } catch (e) {
      rethrow;
    }
  }



}

