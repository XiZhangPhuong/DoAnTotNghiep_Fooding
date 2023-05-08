import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_date.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/screens/profile/profile_controller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../di_container.dart';

class EditProfileController extends GetxController {
  final profileCTL = Get.find<ProfileController>();

  List<String> dropdownText = [
    'Nam',
    'Nữ',
    'Khác',
  ];
  TextEditingController txtPhone = TextEditingController(),
      txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initValueUser();
  }

  String selectedType = 'Nam';
  String dateOfBirth = '';
  File? imageFile;

  ///
  /// On change drop down.
  ///
  void setSelected(String val) {
    selectedType = val;
    update();
  }

  ///
  /// void pick avatar.
  ///
  Future<void> pickAvatar() async {
    final images = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (images == null) return;
    imageFile = File(images.path);
    update();
  }

  ///
  /// Init Value User.
  ///
  void initValueUser() {
    txtPhone.text = profileCTL.user!.phone!;
    txtEmail.text = IZIValidate.nullOrEmpty(profileCTL.user!.email)
        ? ""
        : profileCTL.user!.email!;
    selectedType = IZIValidate.nullOrEmpty(profileCTL.user!.gender)
        ? selectedType
        : profileCTL.user!.gender!;
    txtName.text = IZIValidate.nullOrEmpty(profileCTL.user!.fullName)
        ? "No Name"
        : profileCTL.user!.fullName!;
    dateOfBirth = IZIValidate.nullOrEmpty(profileCTL.user!.dateOfBirth)
        ? IZIDate.formatDate(DateTime.now(), format: "dd/MM/yyyy")
        : profileCTL.user!.dateOfBirth!;
  }

  ///
  /// Update Profile.
  ///
  Future<void> updateAccount() async {
    try {
      if (!validateProfile()) {
        return;
      }
      EasyLoading.show(status: "Đang cập nhật dữ liệu...");
      final User user = User();
      user.fullName = txtName.text.trim();
      user.dateOfBirth = dateOfBirth;
      user.email = txtEmail.text;
      user.gender = selectedType;
      if (!IZIValidate.nullOrEmpty(imageFile)) {
        user.avatar =
            await profileCTL.userRepository.unloadToStorage(imageFile!);
      }
      await profileCTL.userRepository
          .updateUser(user, sl<SharedPreferenceHelper>().getIdUser);
      EasyLoading.dismiss();
      Get.back();
      IZIAlert().success(message: "Cập nhật thành công");
    } catch (e) {
      IZIAlert().error(message: e.toString());
      EasyLoading.dismiss();
    }
  }

  ///
  /// Validate Edit Profile
  ///
  bool validateProfile() {
    if (IZIValidate.nullOrEmpty(txtName.text.trim())) {
      IZIAlert().error(message: "Không được để trống tên");
      return false;
    } else if (IZIValidate.nullOrEmpty(txtEmail.text.trim())) {
      IZIAlert().error(message: "Không được để trống email");
      return false;
    } else if (IZIValidate.nullOrEmpty(txtPhone.text.trim())) {
      IZIAlert().error(message: "Không được để trống tên");
      return false;
    }
    return true;
  }
}
