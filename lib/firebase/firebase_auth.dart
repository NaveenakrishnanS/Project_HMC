import 'package:firebase_auth/firebase_auth.dart';

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

  static Future<void> registerWithPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID and resend token so we can use them later
        // to verify the user's phone number
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the automatic code retrieval timer expires
      },
      timeout: const Duration(seconds: 60),
    );
  }

  static Future<void> verifyPhoneNumberWithCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential);
  }

  static Future<void> signInWithPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID and resend token so we can use them later
        // to verify the user's phone number
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the automatic code retrieval timer expires
      },
      timeout: const Duration(seconds: 60),
    );
  }




/*  static Future<void> verifyPhoneNumber(
      String phoneNumber, Function(String verificationId) verificationCompleted,
      {Function(FirebaseAuthException)? verificationFailed,
        Function(String verificationId, int? resendToken)? codeSent,
        Function(String verificationCode)? codeAutoRetrievalTimeout,
        Duration timeout = const Duration(seconds: 30)}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // This callback will be called whenever verification is done automatically
          // (for example when phone number is verified on the same device)
          // or when the user enters the verification code manually
          verificationCompleted(credential.smsCode!);
        },
        verificationFailed: (FirebaseAuthException e) {
          // This callback will be called when verification fails
          verificationFailed?.call(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          // This callback will be called when verification code is sent to the user's phone
          codeSent?.call(verificationId, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // This callback will be called when auto-retrieval of verification code times out
          codeAutoRetrievalTimeout?.call(verificationId);
        },
        timeout: timeout,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithPhoneNumber(
      String verificationId, String verificationCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> verifyOTP(String verificationId, String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }*/


}
