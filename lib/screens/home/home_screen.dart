import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_input.dart';
import 'package:fooding_project/base_widget/izi_list_view.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomeScreenPage extends GetView<HomeController> {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  // appBar
                  Column(
                    children: [
                      _appBarShoppee(),
                      // textfield search shopppe
                      _textFieldShoppee(),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ImageSlider show
                          Container(
                            margin: EdgeInsets.only(
                              top: IZIDimensions.SPACE_SIZE_3X,
                              left: IZIDimensions.SPACE_SIZE_2X,
                              right: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            height: IZIDimensions.ONE_UNIT_SIZE * 200,
                            child: PageView.builder(
                              controller: controller.pageController,
                              onPageChanged: (value) {
                                controller.onChanGeSlideShow(value);
                              },
                              itemCount: controller.listImageSlider.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_3X),
                                  child: IZIImage(
                                    controller.listImageSlider[index],
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            ),
                          ),
                          // Danh mục sản phẩm
                          _category(controller),
                          _flashSale(controller),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textFieldShoppee() {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.only(
       // top: IZIDimensions.SPACE_SIZE_3X,
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIInput(
        type: IZIInputType.TEXT,
        height: IZIDimensions.ONE_UNIT_SIZE * 50,
        fillColor: const Color(0xffe6e6e6),
        prefixIcon: (focusNode) {
          return Icon(
            Icons.search,
            color: ColorResources.BLACK,
            size: IZIDimensions.ONE_UNIT_SIZE * 35,
          );
        },
        textInputAction: TextInputAction.next,
        placeHolder: 'Bạn muốn ăn gì hôm nay ? ',
        hintStyle: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w400,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
            color: ColorResources.GREY),
      ),
    );
  }

  ///
  /// appbar shoppee
  ///
  Widget _appBarShoppee() {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.only(
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
        top: IZIDimensions.ONE_UNIT_SIZE * 30,
        bottom: IZIDimensions.SPACE_SIZE_5X
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giao đến: ',
            style: TextStyle(
              color: ColorResources.GREY,
              fontFamily: 'Roboto',
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.location_on,
                color: ColorResources.colorShoppeMain,
                size: IZIDimensions.ONE_UNIT_SIZE * 35,
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Text(
                'H23,H500,Xiang 103 ShangHai',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: ColorResources.BLACK,
                  fontFamily: 'Nunito',
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              // Icon(
              //   Icons.keyboard_arrow_right,
              //   color: ColorResources.GREY,
              //   size: IZIDimensions.ONE_UNIT_SIZE * 40,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// search view
  ///
  Widget _searchView(HomeController controller) {
    return Container();
  }

  ///
  /// Flast Sale
  ///
  Widget _flashSale(HomeController controller) {
    return Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Flash Sale',
                style: TextStyle(
                  color: ColorResources.colorShoppeMain,
                  fontFamily: 'Nunito',
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              SlideCountdownSeparated(
                duration: const Duration(hours: 5),
                height: IZIDimensions.ONE_UNIT_SIZE * 40,
                width: IZIDimensions.ONE_UNIT_SIZE * 40,
                textStyle: TextStyle(
                  color: ColorResources.WHITE,
                  fontFamily: 'Roboto',
                  fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.9,
                  fontWeight: FontWeight.w700,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: ColorResources.RED2,
                ),
                onDone: () {},
              )
            ],
          ),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 20,
          ),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 400,
            width: IZIDimensions.iziSize.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.gotoDetailFood();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                      color: ColorResources.WHITE,
                    ),
                    width: IZIDimensions.ONE_UNIT_SIZE * 250,
                    margin:
                        EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_1X * 1.3),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_3X),
                              child: IZIImage(
                                'https://i.ytimg.com/vi/cY0rHIw52kU/maxresdefault.jpg',
                                height: IZIDimensions.ONE_UNIT_SIZE * 200,
                                width: IZIDimensions.ONE_UNIT_SIZE * 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: -IZIDimensions.SPACE_SIZE_3X,
                              top: -IZIDimensions.SPACE_SIZE_1X,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: IZIDimensions.SPACE_SIZE_1X,
                                  horizontal: IZIDimensions.SPACE_SIZE_3X,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_5X),
                                  color: ColorResources.WHITE,
                                  border: Border.all(
                                      width: 1, color: ColorResources.RED2),
                                ),
                                child: Text(
                                  '20% OFF',
                                  style: TextStyle(
                                    color: ColorResources.RED2,
                                    fontFamily: 'Nunito',
                                    fontSize:
                                        IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.7,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 40,
                          child: Text(
                            // controller.listFood[index].name_Food!,
                            'Mì sảo hải sản',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: ColorResources.BLACK,
                                fontSize:
                                    IZIDimensions.FONT_SIZE_SPAN_SMALL * 1.1,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          // 'đ ${controller.listFood[index].price_Food!}',
                          'đ ${120.000}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorResources.RED2,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IZIImage(
                              ImagesPath.icon_star,
                              width: IZIDimensions.ONE_UNIT_SIZE * 30,
                            ),
                            SizedBox(width: IZIDimensions.SPACE_SIZE_1X),
                            Text(
                              '4.8',
                              style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontSize:
                                      IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.9,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              '1.2k đã bán',
                              style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontSize:
                                      IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.9,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// category
  ///
  Widget _category(HomeController controller) {
    return Container(
      color: ColorResources.WHITE,
      //   margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh mục',
            style: TextStyle(
              color: ColorResources.colorShoppeMain,
              fontFamily: 'Nunito',
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 15,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.listCategory.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.snackbar('Notification',
                      controller.listCategory[index].name_Category!);
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                      child: IZIImage(
                        controller.listCategory[index].image_Category!,
                        height: IZIDimensions.ONE_UNIT_SIZE * 70,
                        width: IZIDimensions.ONE_UNIT_SIZE * 70,
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Text(
                      controller.listCategory[index].name_Category!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: IZIDimensions.SPACE_SIZE_3X,
                childAspectRatio: 1),
          ),
        ],
      ),
    );
  }

  

  ///
  /// image slider show using pageview
  ///
  Widget _imageSliderShow(HomeController controller) {
    return Container(
      height: IZIDimensions.ONE_UNIT_SIZE * 250,
      margin: EdgeInsets.symmetric(
          // horizontal: IZIDimensions.ONE_UNIT_SIZE*30,
          vertical: IZIDimensions.SPACE_SIZE_5X),
      child: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: (value) {
              controller.onChanGeSlideShow(value);
            },
            itemCount: controller.listImageSlider.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_5X),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
                  child: IZIImage(controller.listImageSlider[index]),
                ),
              );
            },
          ),
          Positioned(
            right: IZIDimensions.SPACE_SIZE_5X,
            bottom: 0,
            child: Text(
              '${controller.index + 1}/${controller.listImageSlider.length}',
              style: TextStyle(
                color: ColorResources.BLACK,
                fontFamily: 'Nunito',
                fontSize: IZIDimensions.FONT_SIZE_H6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// hinhtronPageView
  ///
  Widget _hinhTronPageView(HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.listImageSlider.length,
        (index) => Container(
          margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_3X),
          height: IZIDimensions.ONE_UNIT_SIZE * 15,
          width: IZIDimensions.ONE_UNIT_SIZE * 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.index == index
                ? ColorResources.RED2
                : ColorResources.GREY,
          ),
        ),
      ),
    );
  }

}
