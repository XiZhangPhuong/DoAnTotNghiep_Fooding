import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fooding_project/base_widget/custom_scrollbar_gridview.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_input.dart';
import 'package:fooding_project/base_widget/izi_list_view.dart';
import 'package:fooding_project/base_widget/izi_text.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
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
          backgroundColor: ColorResources.WHITE,
          body: SafeArea(
            child: Container(
              color: ColorResources.WHITE,
              // margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
              padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_3X,
                  vertical: IZIDimensions.SPACE_SIZE_3X),
              child: Column(
                children: [
                  // address
                  _andressCustomer(),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  // search
                  _searchView(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // image slideshow
                          _imageSlideShow(controller),
                          // category
                          _categoryFood(),
                          // flash sale
                          _flashSale(),
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

  ///
  /// flastSale
  ///
  Widget _flashSale() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Đang giảm giá',
                style: TextStyle(
                  color: ColorResources.titleLogin,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H5,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              SlideCountdownSeparated(
                duration: const Duration(hours: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: ColorResources.colorMain,
                ),
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                    color: ColorResources.WHITE),
                height: IZIDimensions.ONE_UNIT_SIZE * 40,
                width: IZIDimensions.ONE_UNIT_SIZE * 40,
              )
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          Container(
            height: IZIDimensions.ONE_UNIT_SIZE * 400,
            color: ColorResources.WHITE,
            child: 
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.gotoDetailFood('123');
                  },
                  child: Card(
                    elevation: 1,
                    child: Container(
                      width: IZIDimensions.ONE_UNIT_SIZE * 300,
                      margin:
                          EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_3X),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_5X),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                IZIDimensions.BORDER_RADIUS_3X),
                            child: IZIImage(
                              'https://images.foody.vn/res/g100001/1000000008/prof/s280x175/foody-upload-api-foody-mobile-dd-200414154651.jpg',
                              height: IZIDimensions.ONE_UNIT_SIZE * 230,
                              width: IZIDimensions.ONE_UNIT_SIZE * 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_2X),
                            child: Text(
                              'Cơm chiên trứng',
                              style: TextStyle(
                                color: ColorResources.titleLogin,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_2X),
                            child: Text(
                              '25/4 Phan Thanh,phường Thạc Gián',
                              style: TextStyle(
                                color: ColorResources.GREY,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                                fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
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
  /// Category Food
  ///
  Widget _categoryFood() {
    return Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh mục',
            style: TextStyle(
              color: ColorResources.titleLogin,
              fontFamily: NUNITO,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H5,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          Container(
            height: IZIDimensions.iziSize.height * .34,
            child: CustomScrollbar(
                itemCount: controller.listCategory.length,
                alignment: Alignment.bottomCenter,
                thumbColor: Colors.red,
                strokeWidth:
                    (IZIDimensions.iziSize.width * 0.246).ceilToDouble(),
                strokeHeight:
                    (IZIDimensions.iziSize.width * 0.045).ceilToDouble(),
                scrollbarMargin: const EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X * 0),
                child: (index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_7X),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_7X),
                              child: IZIImage(
                                controller.listCategory[index].image_Category!,
                                width: IZIDimensions.ONE_UNIT_SIZE * 90,
                                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        IZIText(
                          text: controller.listCategory[index].name_Category!,
                          maxLine: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            color: const Color(0xff464647),
                          ),
                        ),
                      ],
                    )),
          ),
        ],
      ),
    );
  }

  ///
  /// image slide show
  ///
  Container _imageSlideShow(HomeController controller) {
    return Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
      child: ImageSlideshow(
        indicatorColor: ColorResources.colorMain,
        indicatorRadius: 4,
        isLoop: true,
        children: List.generate(
            controller.listImageSlider.length,
            (index) => ClipRRect(
                  borderRadius:
                      BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
                  child: IZIImage(controller.listImageSlider[index]),
                )),
      ),
    );
  }

  ///
  /// search view
  ///
  GestureDetector _searchView() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_3X,
          horizontal: IZIDimensions.SPACE_SIZE_2X,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
          color: ColorResources.BACK_GROUND,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: ColorResources.BLACK,
              size: IZIDimensions.ONE_UNIT_SIZE * 30,
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_1X,
            ),
            Text(
              'Bạn muốn ăn gì hôm nay ? ',
              style: TextStyle(
                color: ColorResources.GREY,
                fontFamily: NUNITO,
                fontWeight: FontWeight.w400,
                fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// _andressCustomer
  ///
  Row _andressCustomer() {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: ColorResources.colorMain,
          size: IZIDimensions.ONE_UNIT_SIZE * 35,
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        Text(
          '123 Lê Hữu Trác',
          maxLines: 1,
          style: TextStyle(
            color: ColorResources.titleLogin,
            fontFamily: NUNITO,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
            fontSize: IZIDimensions.FONT_SIZE_H6,
          ),
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_1X,
        ),
        Icon(
          Icons.keyboard_arrow_right,
          color: ColorResources.GREY,
          size: IZIDimensions.ONE_UNIT_SIZE * 35,
        ),
      ],
    );
  }
}
