import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../helper/izi_dimensions.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/images_path.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordPage extends GetView {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: ForgotPasswordController(),
        builder: (ForgotPasswordController controller) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.1,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: IZIDimensions.iziSize.height * 0.08,
                  ),
                  IZIImage(
                    "",
                    height: IZIDimensions.iziSize.height * 0.45,
                  ),
                  Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      color: ColorResources.titleLogin,
                      fontSize: IZIDimensions.FONT_SIZE_H1 * 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_5X * 1.5,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: ColorResources.colorTextContentForgot,
                        ),
                        text:
                            'Đừng lo lắng ! Vui lòng nhập số điện thoại, chúng tôi sẽ gửi mã OTP về số điện thoại này.',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_5X * 1.3,
                    ),
                    child: IZIInput(
                      type: IZIInputType.PHONE,
                      fillColor: ColorResources.backgroundTextField,
                      placeHolder: 'Nhập số điện thoại',
                  
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: GetBuilder(
        builder: (ForgotPasswordController controller) =>
            MediaQuery.of(context).viewInsets.bottom > 0
                ? const SizedBox()
                : Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    width: IZIDimensions.iziSize.width,
                    height: IZIDimensions.ONE_UNIT_SIZE * 90,
                    child: Center(
                      child: GestureDetector(
                        onTap: ()  {
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
                            "Tiếp tục",
                            style: TextStyle(
                              color: ColorResources.WHITE,
                              fontWeight: FontWeight.w700,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
