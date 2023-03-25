// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/auth/login/login_controller.dart';
import 'package:fooding_project/screens/components/button_app.dart';
import 'package:get/get.dart';

import '../../../base_widget/izi_input.dart';
import '../../../helper/izi_validate.dart';
import '../../../utils/color_resources.dart';

class LoginPages extends GetView<LoginController> {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return GetBuilder(
      init: LoginController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(h * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),

                  //header of page
                  _header(h),

                  SizedBox(
                    height: h * 0.01,
                  ),

                  // Login.
                  _formLogin(h, w),

                  Spacer(),

                  // Footer of page
                  _footer(w),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _footer(double w) {
    return Container(
      width: w,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bạn không có tài khoản? "),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Đăng kí',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _formLogin(double h, double w) {
    return Column(
      children: [
        phoneInput(),
        SizedBox(
          height: h * 0.01,
        ),
        passwordInput(),
        SizedBox(
          height: h * 0.02,
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Center(
          child: SizedBox(
            height: h * 0.055,
            width: w * 0.6,
            child: ButtonFooding(
              text: "ĐĂNG NHẬP",
              ontap: () => controller.goToDashBoard(),
              border: IZIDimensions.BORDER_RADIUS_3X,
            ),
          ),
        ),
      ],
    );
  }

  Column _header(double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chào mừng quay trở lại',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: h * 0.008,
        ),
        Text(
          'Đồ ăn ngon, đồ ăn an toàn, giao nhanh nhất',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  ///
  /// Phone Input.
  ///
  Widget phoneInput() {
    return Padding(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIInput(
        type: IZIInputType.PHONE,
        placeHolder: 'Nhập số điện thoại',
        fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
        borderRadius: 5,
        textInputAction: TextInputAction.next,
        disbleError: true,
        onChanged: (val) {},
        prefixIcon: (val) {
          return Icon(
            Icons.phone,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_4
                : val!.hasFocus
                    ? ColorResources.COLOR_BUTTON
                    : ColorResources.NEUTRALS_4,
          );
        },
        cursorColor: ColorResources.NEUTRALS_5,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorResources.COLOR_BUTTON,
        ),
      ),
    );
  }

  ///
  /// Password input.
  ///
  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIInput(
        type: IZIInputType.PASSWORD,
        placeHolder: 'Nhập password',
        disbleError: true,
        prefixIcon: (val) {
          return Icon(
            Icons.lock,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_4
                : val!.hasFocus
                    ? ColorResources.COLOR_BUTTON
                    : ColorResources.NEUTRALS_4,
          );
        },
        cursorColor: ColorResources.NEUTRALS_5,
        fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
        borderRadius: 5,
        onChanged: (val) {},
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorResources.COLOR_BUTTON,
        ),
      ),
    );
  }
}
