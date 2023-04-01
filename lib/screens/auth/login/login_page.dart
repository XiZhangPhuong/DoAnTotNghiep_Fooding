import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base_widget/izi_input.dart';
import '../../../../helper/izi_validate.dart';
import '../../../base_widget/izi_image.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../utils/color_resources.dart';
import 'login_controller.dart';

class LoginPage extends GetView {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.colorBackground,
      body: GetBuilder(
        init: LoginController(),
        builder: (LoginController controller) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header of page.
                _header(),

                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_5X * 1.5,
                ),

                // Login Form.
                _loginForm(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// header of page
  ///
  Column _header() {
    return Column(
      children: [
        SizedBox(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height * 0.25,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: IZIDimensions.iziSize.height * 0.17,
                child: IZIImage(
                  "",
                ),
              ),
              Positioned(
                top: IZIDimensions.SPACE_SIZE_5X * 2,
                right: 0,
                child: IZIImage(
                  "",
                  height: IZIDimensions.ONE_UNIT_SIZE * 90,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_3X,
        ),
        Text(
          'Đăng nhập',
          style: TextStyle(
            color: ColorResources.titleLogin,
            fontWeight: FontWeight.w500,
            fontSize: IZIDimensions.FONT_SIZE_H1 * 1.3,
          ),
        ),
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_1X,
        ),
        Text(
          'Chào mừng bạn đến với Booking',
          style: TextStyle(
            color: ColorResources.titleLogin,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
            fontFamily: 'Manrope',
          ),
        ),
      ],
    );
  }

  ///
  /// Phone Input.
  ///
  Widget phoneInput(LoginController controller) {
    return Padding(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIInput(
        type: IZIInputType.PHONE,
        controller: controller.phoneEditingController,
        placeHolder: 'Nhập số điện thoại',
        fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
        borderRadius: 5,
        disbleError: true,
        textInputAction: TextInputAction.next,
        onChanged: (val) {},
        prefixIcon: (val) {
          return Icon(
            Icons.phone,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_4
                : val!.hasFocus
                    ? ColorResources.PRIMARY_3
                    : ColorResources.NEUTRALS_4,
          );
        },
        cursorColor: ColorResources.NEUTRALS_5,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorResources.PRIMARY_3,
        ),
      ),
    );
  }

  ///
  /// Password input.
  ///
  Widget passwordInput(LoginController controller) {
    return Padding(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIInput(
        type: IZIInputType.PASSWORD,
        controller: controller.passwordEditingController,
        placeHolder: 'Mật Khẩu',
        fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
        borderRadius: 5,
        disbleError: true,
        onChanged: (val) {},
        prefixIcon: (val) {
          return Icon(
            Icons.lock,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_4
                : val!.hasFocus
                    ? ColorResources.PRIMARY_3
                    : ColorResources.NEUTRALS_4,
          );
        },
        cursorColor: ColorResources.NEUTRALS_5,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorResources.PRIMARY_3,
        ),
      ),
    );
  }

  ///
  /// Login form.
  ///
  Widget _loginForm(LoginController controller) {
    return Container(
      width: IZIDimensions.iziSize.width,
      color: ColorResources.WHITE,
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
        left: IZIDimensions.SPACE_SIZE_3X,
        right: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        children: [
          Text(
            'Đăng nhập với số điện thoại',
            style: TextStyle(
              color: ColorResources.PRIMARY_5,
              fontFamily: 'Manrope',
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          const Divider(
            height: 1,
            color: ColorResources.colorDivider,
          ),
          phoneInput(controller),
          passwordInput(controller),
          Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_2X,
                    ),
                  ),
                  activeColor: ColorResources.PRIMARY_3,
                  value: controller.isCheck,
                  onChanged: (v) {},
                  checkColor: ColorResources.checkBoxColor,
                ),
              ),
              Text(
                "Ghi nhớ tài khoản",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          GestureDetector(
            onTap: () {
              controller.gotoDashBoard();
            },
            child: Container(
              height: IZIDimensions.ONE_UNIT_SIZE * 90,
              width: IZIDimensions.iziSize.width * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorResources.COLOR_BUTTON,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.SPACE_SIZE_4X,
                ),
              ),
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                  color: ColorResources.WHITE,
                  fontWeight: FontWeight.w700,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  fontFamily: 'Manrope',
                ),
              ),
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          GestureDetector(
            onTap: () {
              controller.goToForgotPassword();
            },
            child: const Text(
              'Quên mật khẩu?',
              style: TextStyle(
                fontFamily: 'Manrope',
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bạn chưa có tài khoản? ',
                style: TextStyle(
                  fontFamily: 'Manrope',
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.goToSingUp();
                },
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
        ],
      ),
    );
  }
}
