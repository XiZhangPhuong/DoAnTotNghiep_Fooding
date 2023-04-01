import 'package:flutter/material.dart';
import 'package:fooding_project/screens/introduction/introduction_controller.dart';

import 'package:get/get.dart';

import '../../base_widget/izi_image.dart';
import '../../helper/izi_dimensions.dart';
import '../../utils/color_resources.dart';
import '../components/button_app.dart';

class IntroductionPage extends GetView {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      body: GetBuilder(
        init: IntroductionController(),
        builder: (controller) {
          return Stack(
            children: [
              // page view
              Positioned.fill(
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
                  height: IZIDimensions.iziSize.height,
                  child: PageView.builder(
                    onPageChanged: (index) =>
                        controller.onChangePageIndex(index),
                    controller: controller.pageController,
                    itemCount: controller.introductionData.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          _pageIntroduction(
                            controller,
                            index,
                          ),
                          Positioned(
                            top: IZIDimensions.iziSize.height * 0.52,
                            right: 0,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: IZIDimensions.iziSize.width * 0.05,
                                vertical: IZIDimensions.iziSize.width * 0.025,
                              ),
                              width: controller.currentIndex.value ==
                                      controller.introductionData.length - 1
                                  ? IZIDimensions.iziSize.width
                                  : IZIDimensions.iziSize.width * 0.6,
                              child: Text(
                                controller.introductionData[
                                        controller.currentIndex.value]['title']
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorResources.PRIMARY_5,
                                  fontSize: IZIDimensions.FONT_SIZE_H1 * 1.2,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Mali',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: IZIDimensions.iziSize.height * 0.65,
                            child: Container(
                              padding: EdgeInsets.all(
                                IZIDimensions.SPACE_SIZE_5X,
                              ),
                              width: IZIDimensions.iziSize.width,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    color: ColorResources.PRIMARY_5,
                                    height: 1.5,
                                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                  ),
                                  text: controller.introductionData[index]
                                          ['content']
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              if (controller.currentIndex.value != 2)
                Positioned(
                  bottom: IZIDimensions.iziSize.height * 0.02,
                  child: Container(
                    padding: EdgeInsets.all(IZIDimensions.iziSize.width * 0.08),
                    width: IZIDimensions.iziSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.onLastPage();
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: ColorResources.PRIMARY_5,
                              fontWeight: FontWeight.w700,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              controller.introductionData.length,
                              (index) => Obx(
                                () {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      right: index !=
                                              controller
                                                      .introductionData.length -
                                                  1
                                          ? IZIDimensions.SPACE_SIZE_2X
                                          : 0,
                                    ),
                                    width:
                                        controller.currentIndex.value == index
                                            ? IZIDimensions.ONE_UNIT_SIZE * 19
                                            : IZIDimensions.ONE_UNIT_SIZE * 17,
                                    height:
                                        controller.currentIndex.value == index
                                            ? IZIDimensions.ONE_UNIT_SIZE * 19
                                            : IZIDimensions.ONE_UNIT_SIZE * 17,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          controller.currentIndex.value == index
                                              ? ColorResources.PRIMARY_5
                                              : ColorResources.camNhat
                                                  .withOpacity(.5),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.onNextPage();
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: ColorResources.PRIMARY_5,
                              fontWeight: FontWeight.w700,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Button.
              if (controller.currentIndex.value == 2)
                Positioned(
                  bottom: IZIDimensions.iziSize.height * 0.02,
                  left: 0,
                  right: 0,
                  child: ButtonFooding(
                    text: "Bắt đầu".toUpperCase(),
                    ontap: () => controller.onAuthPage(),
                    border: IZIDimensions.BORDER_RADIUS_4X,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  ///
  /// Page introduction.
  ///
  Widget _pageIntroduction(IntroductionController controller, int index) {
    return Container(
      padding: EdgeInsets.only(
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
        top: IZIDimensions.SPACE_SIZE_5X,
      ),
      width: IZIDimensions.iziSize.width,
      height: IZIDimensions.iziSize.height * 0.5,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            IZIDimensions.BORDER_RADIUS_7X * 1.5,
          ),
          bottomRight: Radius.circular(
            IZIDimensions.BORDER_RADIUS_7X * 1.5,
          ),
        ),
      ),
      child: IZIImage(
        controller.introductionData[index]['image'].toString(),
        height: index == 2
            ? IZIDimensions.iziSize.height * 0.4
            : IZIDimensions.iziSize.height * 0.45,
      ),
    );
  }
}
