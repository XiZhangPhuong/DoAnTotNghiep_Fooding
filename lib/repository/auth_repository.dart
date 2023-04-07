import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:get/get.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;

  Future<void> phoneAuthentication(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+84$phoneNumber",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
      },
      
      verificationFailed: (error) {
        IZIAlert().error(
          message: error.toString(),
        );
        print(error.toString());
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth
        .signInWithCredential(
          PhoneAuthProvider.credential(
            verificationId: verificationId.value,
            smsCode: otp,
          ),
        );
      
    return credentials.user != null ? true : false;
  }
}
