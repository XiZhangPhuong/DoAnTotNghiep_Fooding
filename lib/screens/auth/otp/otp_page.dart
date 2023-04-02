import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/images_path.dart';
import 'otp_controller.dart';

class OTPPage extends GetView {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      body: GetBuilder(
        init: OTPController(),
        builder: (OTPController controller) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.1,
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: IZIDimensions.iziSize.width,
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
                      'Xác nhận OTP',
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
                        text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: ColorResources.colorTextContentForgot,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Đã gửi mã OTP tới ',
                              ),
                              TextSpan(
                                text: controller.result[1],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_5X,
                    ),
                    SizedBox(
                      width: IZIDimensions.iziSize.width * 0.8,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        onChanged: (value) {
                          controller.otpCode = value;
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_4X,
                          ),
                          fieldHeight: IZIDimensions.ONE_UNIT_SIZE * 70,
                          fieldWidth: IZIDimensions.ONE_UNIT_SIZE * 70,
                          activeFillColor: ColorResources.colorOTP,
                          disabledColor: ColorResources.PRIMARY_1,
                          inactiveFillColor: ColorResources.WHITE,
                          inactiveColor: ColorResources.NEUTRALS_4,
                          activeColor: ColorResources.colorOTP,
                          selectedFillColor: ColorResources.colorOTP,
                        ),
                        cursorColor: ColorResources.WHITE,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    Text(
                      '00:${controller.count}s',
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
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
                            children: [
                              TextSpan(
                                text: 'Bạn chưa nhận được mã? ',
                              ),
                              TextSpan(
                                text: 'Gửi lại',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap =
                                //       () => controller.onClickOtpSendAgain(),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
          ? const SizedBox()
          : GetBuilder(
              builder: (OTPController controller) => Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await controller.onPageChange();
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
                        "Xác nhận",
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
