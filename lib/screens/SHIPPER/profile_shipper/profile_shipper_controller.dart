import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/base_widget/my_dialog_alert_done.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/user.dart' as model;
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class ProfileShipperController extends GetxController {
  model.User? user;
  UserRepository userRepository = GetIt.I.get<UserRepository>();
  bool isLoading = false;

  ///
  /// Find user.
  ///
  Future<void> findUser() async {
    user = await userRepository.findUser();
    if (user!.isDeleted!) {
      await Get.toNamed(AuthRoutes.LOGIN);
      return;
    }
    isLoading = true;
    update();
  }

  ///
  /// Go to Edit Profile.
  ///
  Future<void> gotoEditProfile() async {
    await Get.toNamed(
      ProfileRoutes.EDIT_PROFILE,
    );
    await findUser();
  }

  ///
  /// go to chart
  ///
 void gotoChart(){
   Get.toNamed(ProfileRoutes.CHART);
 }
  ///
  /// Log out.
  ///
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.dialog(DialogCustom(
      description: 'Bạn có muốn đăng xuất ? ',
      agree: 'Có',
      cancel1: 'Không',
      onTapConfirm: () {
        IZIAlert().success(message: "Đăng xuất thành công");
        sl<SharedPreferenceHelper>().removeLogin();
        sl<SharedPreferenceHelper>().removeIdUser();
        Get.offNamed(AuthRoutes.LOGIN);
      },
      onTapCancle: () {
        Get.back();
      },
    ));
  }

  @override
  void onInit() {
    super.onInit();
    findUser();
  }
}
