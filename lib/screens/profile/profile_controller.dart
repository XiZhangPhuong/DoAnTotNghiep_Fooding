import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../di_container.dart';
import '../../model/user.dart' as model;
import '../../routes/routes_path/auth_routes.dart';
import '../../sharedpref/shared_preference_helper.dart';

class ProfileController extends GetxController {
  UserRepository userRepository = GetIt.I.get<UserRepository>();
  model.User? user;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    findUser();
  }

  ///
  /// Go to Edit Profile.
  ///
  Future<void> gotoEditProfile() async {
    await Get.toNamed(
      ProfileRoutes.EDITPROFILE,
    );
    await findUser();
  }

  ///
  /// Log out.
  ///
  void logout() async {
    await FirebaseAuth.instance.signOut();
    sl<SharedPreferenceHelper>().removeLogin();
    sl<SharedPreferenceHelper>().removeIdUser();
    Get.offNamed(AuthRoutes.LOGIN);
    IZIAlert().success(message: "Đăng xuất thành công");
  }

  ///
  /// Find user.
  ///
  Future<void> findUser() async {
    isLoading.value = true;
    user = await userRepository.findUser();
    if (user!.isDeleted!) {
      await Get.toNamed(AuthRoutes.LOGIN);
      return;
    }
    isLoading.value = false;
    update();
  }

  ///
  /// Go to status order.
  ///
  void gotoStatusOrder(int status) {
    Get.toNamed(
      ProfileRoutes.STATUSORDER,
      arguments: status,
    );
  }
}
