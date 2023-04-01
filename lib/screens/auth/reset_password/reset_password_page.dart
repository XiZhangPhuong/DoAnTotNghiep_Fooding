import 'package:flutter/material.dart';
import 'package:fooding_project/screens/auth/reset_password/reset_password_controller.dart';
import 'package:get/get.dart';

import '../../../../base_widget/izi_image.dart';
import '../../../../base_widget/izi_input.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/images_path.dart';

class ResetPasswordPage extends GetView {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: ResetPasswordController(),
          builder: (ResetPasswordController controller) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
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
                        'Đặt lại mật khẩu',
                        style: TextStyle(
                          color: ColorResources.titleLogin,
                          fontSize: IZIDimensions.FONT_SIZE_H1 * 1.3,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito',
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
                                'Nhập mật khẩu mới của bạn ở bên dưới.Chúng tôi chỉ đang tăng cường an toàn !',
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
                          type: IZIInputType.PASSWORD,
                          fillColor: ColorResources.backgroundTextField,
                          textInputAction: TextInputAction.next,
                          disbleError: true,
                          placeHolder: 'Nhập mật khẩu mới',
                          onChanged: (value) {
                            
                          },
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
                          type: IZIInputType.PASSWORD,
                          disbleError: true,
                          fillColor: ColorResources.backgroundTextField,
                          placeHolder: 'Xác nhận mật khẩu mới',
                          onChanged: (value) {
                           
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
          ? const SizedBox()
          : GetBuilder(
              builder: (ResetPasswordController controller) => Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.close(3);
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
