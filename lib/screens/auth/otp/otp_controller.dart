import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  bool isClick = false;
  Timer? timer;
  int count = 50;

  @override
  void onInit() {
    super.onInit();
    countDown();
    sendOTP();
  }

  ///
  /// Count down.
  ///
  void countDown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count < 1) {
        isClick = true;
      } else {
        --count;
        update();
      }
    });
  }

  ///
  /// On page change.
  ///
  void onPageChange() {
    final result = Get.arguments as List<String>;
    if (result[0] == "create") {
      Get.close(2);
    } else {
      Get.toNamed(
        AuthRoutes.RESET,
      );
    }
  }

  Future<void> sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+840332854541',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    print("123");
  }
}
