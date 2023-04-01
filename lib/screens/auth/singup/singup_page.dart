import 'package:flutter/material.dart';
import 'package:fooding_project/screens/auth/singup/singup_controller.dart';
import 'package:get/get.dart';


import '../../../../helper/izi_validate.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/images_path.dart';

class SingupPage extends GetView {
  const SingupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SingupController(),
        builder: (SingupController controller) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                //
                // Header of page.
                _header(),

                // Form Singup.
                _formSingup(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// Phone Input.
  ///
  Widget phoneInput(SingupController controller) {
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
  Widget passwordInput(SingupController controller) {
    return Padding(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIInput(
        type: IZIInputType.PASSWORD,
        placeHolder: 'Mật Khẩu',
        fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
        borderRadius: 5,
        disbleError: true,
        textInputAction: TextInputAction.next,
        onChanged: (val) {
        },
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
  /// Confirm Password
  ///
  Widget confirmPasswordInput(SingupController controller) {
    return Padding(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIInput(
        type: IZIInputType.PASSWORD,
        placeHolder: 'Nhập lại mật khẩu',
        disbleError: true,
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
        fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
        borderRadius: 5,
        onChanged: (val) {
        },
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorResources.PRIMARY_3,
        ),
      ),
    );
  }

  ///
  /// Form singup.
  ///
  Widget _formSingup(SingupController controller) {
    return Padding(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        children: [
          // Phone Input.
          phoneInput(controller),

          // Password Input.
          passwordInput(controller),

          //Confirm password Input.
          confirmPasswordInput(controller),

          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          GestureDetector(
            onTap: ()   {
               controller.gotoOTP();
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
                "Tạo tài khoản",
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
            height: IZIDimensions.iziSize.height * 0.04,
          ),
          SizedBox(
            width: IZIDimensions.iziSize.width,
            child: Row(
              children: const [
                Expanded(
                  child: Divider(
                    height: 2,
                  ),
                ),
                Flexible(
                  child: Text(
                    'Hoặc đăng ký với',
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Padding(
            padding: EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Row(
              children: [
                Container(
                  width: IZIDimensions.iziSize.width * 0.4,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_4X,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: IZIImage(
                          "",
                          height: IZIDimensions.ONE_UNIT_SIZE * 70,
                        ),
                      ),
                      Text(
                        'Google',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_2X,
                ),
                Container(
                  width: IZIDimensions.iziSize.width * 0.4,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_4X,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Center(
                          child: IZIImage(
                            "",
                            height: IZIDimensions.ONE_UNIT_SIZE * 70,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        'Facebook',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              'Đăng nhập',
              style: TextStyle(
                color: ColorResources.PRIMARY_5,
                fontWeight: FontWeight.w700,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Header of page.
  ///
  Widget _header() {
    return Column(
      children: [
        SizedBox(
          height: IZIDimensions.iziSize.height * 0.35,
          width: IZIDimensions.iziSize.width,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: IZIImage(
              "",
              height: IZIDimensions.iziSize.height * 0.25,
            ),
          ),
        ),
        Text(
          'Tạo tài khoản',
          style: TextStyle(
            color: ColorResources.titleLogin,
            fontSize: IZIDimensions.FONT_SIZE_H1 * 1.3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
