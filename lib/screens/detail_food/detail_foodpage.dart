import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/detail_food/detail_foodcontroller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class DetailFoodPage extends GetView<DetailFoodController> {
  const DetailFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailFoodController(),
      builder: (DetailFoodController controller) {
        return Scaffold(
          bottomSheet: _bottomSheet(),
          backgroundColor: ColorResources.BACK_GROUND,
          body: Container(
              margin: EdgeInsets.only(bottom: IZIDimensions.ONE_UNIT_SIZE * 50),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ImageSlideshow(
                        height: IZIDimensions.ONE_UNIT_SIZE * 400,
                        indicatorColor: ColorResources.colorMain,
                        indicatorRadius: 4,
                        isLoop: true,
                        onPageChanged: (value) {
                          controller.changeSlideShow(value);
                        },
                        children: List.generate(
                            controller.listImageSlider.length,
                            (index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_2X),
                                  child: IZIImage(
                                      controller.listImageSlider[index]),
                                )),
                      ),
                      Positioned(
                        left: IZIDimensions.SPACE_SIZE_2X,
                        top: IZIDimensions.ONE_UNIT_SIZE * 80,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding:
                                EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(0, 0, 0, 0.3)),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: ColorResources.WHITE,
                                size: IZIDimensions.ONE_UNIT_SIZE * 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: IZIDimensions.SPACE_SIZE_2X,
                        bottom: IZIDimensions.ONE_UNIT_SIZE * 20,
                        child: Container(
                          padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_3X),
                              color: const Color.fromRGBO(0, 0, 0, 0.3)),
                          child: Center(
                            child: Text(
                              '${controller.currentIndex + 1}/${controller.listImageSlider.length}',
                              style: TextStyle(
                                color: ColorResources.WHITE.withOpacity(0.7),
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cơm gà xối mở Thu Phượng',
                              style: TextStyle(
                                color: ColorResources.titleLogin,
                                fontFamily: NUNITO,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w700,
                                fontSize: IZIDimensions.FONT_SIZE_H4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.clickFavorite();
                              },
                              child: Icon(Icons.favorite_border,
                                  size: IZIDimensions.ONE_UNIT_SIZE * 40,
                                  color: controller.isCheckFavorite
                                      ? ColorResources.colorMain
                                      : ColorResources.BLACK),
                            ),
                          ],
                        ),
                        Text(
                          '102 Phan Châu Trinh-Hải Châu-Đà Nẵng',
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: NUNITO,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Row(
                          children: [
                            RatingStars(
                              value: 4.5,
                              starCount: 5,
                              starSize: IZIDimensions.ONE_UNIT_SIZE * 30,
                              starColor: Colors.yellow,
                              onValueChanged: (value) {},
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            Text(
                              '1.2k đã bán',
                              style: TextStyle(
                                color: ColorResources.BLACK,
                                fontFamily: NUNITO,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Row(
                          children: [
                            Container(
                              height: IZIDimensions.ONE_UNIT_SIZE * 10,
                              width: IZIDimensions.ONE_UNIT_SIZE * 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResources.colorMain),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            Text(
                              'Đang mở cửa : 8:30 - 22:30',
                              style: TextStyle(
                                color: ColorResources.BLACK,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w400,
                                fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '120.000 vnđ',
                              style: TextStyle(
                                color: ColorResources.colorMain,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w600,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 50,
                          width: IZIDimensions.iziSize.width,
                          child: const Divider(),
                        ),

                        // các món của cửa hàng
                        Text(
                          'Có thể bạn thích',
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Container(
                          height: IZIDimensions.ONE_UNIT_SIZE * 150,
                          color: ColorResources.WHITE,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 1,
                                  child: Container(
                                    width: IZIDimensions.iziSize.width * 0.9,
                                    margin: EdgeInsets.only(
                                        right: IZIDimensions.SPACE_SIZE_3X),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          IZIDimensions.BORDER_RADIUS_5X),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              IZIDimensions.BORDER_RADIUS_3X),
                                          child: IZIImage(
                                            'https://images.foody.vn/res/g100001/1000000008/prof/s280x175/foody-upload-api-foody-mobile-dd-200414154651.jpg',
                                            height:
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    150,
                                            width: IZIDimensions.ONE_UNIT_SIZE *
                                                150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: IZIDimensions
                                                        .SPACE_SIZE_2X),
                                                child: Text(
                                                  'Cơm chiên trứng',
                                                  style: TextStyle(
                                                    color: ColorResources
                                                        .titleLogin,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_H6,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: IZIDimensions
                                                        .SPACE_SIZE_2X),
                                                child: Text(
                                                  'Đã bán 1.2k',
                                                  style: TextStyle(
                                                    color: ColorResources.BLACK,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_SPAN_SMALL,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: IZIDimensions
                                                        .SPACE_SIZE_2X),
                                                child: Text(
                                                  '255000 vnđ',
                                                  style: TextStyle(
                                                    color: ColorResources
                                                        .colorMain,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_SPAN_SMALL,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                  )
                ],
              )),
        );
      },
    );
  }

  ///
  /// bottom sheet
  ///
  Widget _bottomSheet() {
    return Container(
      height: IZIDimensions.ONE_UNIT_SIZE * 80,
      width: IZIDimensions.iziSize.width,
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Row(
        children: [
          // cart count
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_3X,
                  ),
                  border: Border.all(width: 1, color: ColorResources.colorMain)),
                  child: Center(
                    child: Badge(
                  badgeContent: Text(
                    '3',
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT * 0.8,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito',
                      color: ColorResources.WHITE,
                    ),
                  ),
                  child:  Icon(Icons.shopping_cart,size: IZIDimensions.ONE_UNIT_SIZE*40,color: ColorResources.colorMain,),
                ),
                  ),
            ),
          ),
          SizedBox(width: IZIDimensions.SPACE_SIZE_3X,),
          // button pay ment
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: ColorResources.colorMain,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_4X,
                ),
              ),
              child: Center(
                child: Text(
                  'Trang thanh toán',
                  style: TextStyle(
                    color: ColorResources.WHITE,
                    fontFamily: NUNITO,
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// appBar
  ///
  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Chi tiết cửa hàng',
        style: TextStyle(
          color: ColorResources.WHITE,
          fontFamily: 'Nunito',
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: IZIDimensions.ONE_UNIT_SIZE * 40,
          )),
    );
  }
}
