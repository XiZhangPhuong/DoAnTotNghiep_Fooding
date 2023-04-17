import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
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
        return controller.isLoading == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                //  bottomSheet: _bottomSheet(),
                // floating button
                floatingActionButton: _floattingButton(controller),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startFloat,
                backgroundColor: ColorResources.BACK_GROUND,
                body: Container(
                    margin: EdgeInsets.only(
                        bottom: IZIDimensions.ONE_UNIT_SIZE * 0),
                    child: Column(
                      children: [
                        _imageSlider(controller),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.productsModel!.name!,
                                            style: TextStyle(
                                              color: ColorResources.titleLogin,
                                              fontFamily: NUNITO,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H4,
                                            ),
                                          ),
                                          // add cart
                                          GestureDetector(
                                            onTap: () {
                                              controller.clickFavorite();
                                            },
                                            child: Icon(Icons.favorite_border,
                                                size: IZIDimensions
                                                        .ONE_UNIT_SIZE *
                                                    40,
                                                color: controller
                                                        .isCheckFavorite
                                                    ? ColorResources.colorMain
                                                    : ColorResources.BLACK),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        IZIValidate.nullOrEmpty(
                                                controller.userModel)
                                            ? ''
                                            : controller.userModel!.address!,
                                        style: TextStyle(
                                          color: ColorResources.BLACK,
                                          fontFamily: NUNITO,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: IZIDimensions
                                              .FONT_SIZE_SPAN_SMALL,
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
                                            starSize:
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    30,
                                            starColor: Colors.yellow,
                                            onValueChanged: (value) {},
                                          ),
                                          SizedBox(
                                            width: IZIDimensions.SPACE_SIZE_3X,
                                          ),
                                          Text(
                                            '${controller.productsModel!.sold} đã bán',
                                            style: TextStyle(
                                              color: ColorResources.BLACK,
                                              fontFamily: NUNITO,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w400,
                                              fontSize: IZIDimensions
                                                  .FONT_SIZE_SPAN_SMALL,
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
                                            height:
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    10,
                                            width: IZIDimensions.ONE_UNIT_SIZE *
                                                10,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    ColorResources.colorMain),
                                          ),
                                          SizedBox(
                                            width: IZIDimensions.SPACE_SIZE_1X,
                                          ),
                                          Text(
                                            controller.timeStore,
                                            style: controller.timeStore
                                                    .contains('Đã đóng cửa')
                                                ? TextStyle(
                                                    color: ColorResources.BLACK,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w400,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_SPAN_SMALL,
                                                  )
                                                : TextStyle(
                                                    color: ColorResources.BLACK,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_SPAN_SMALL,
                                                  ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '${IZIPrice.currencyConverterVND(controller.productsModel!.price!.toDouble())}đ',
                                            style: TextStyle(
                                              color: ColorResources.colorMain,
                                              fontFamily: NUNITO,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            IZIDimensions.ONE_UNIT_SIZE * 50,
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

                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            controller.listProducts.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: IZIDimensions
                                                    .SPACE_SIZE_1X),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    IZIImage(
                                                      controller
                                                          .listProducts[index]
                                                          .image!
                                                          .first,
                                                      height: IZIDimensions
                                                              .ONE_UNIT_SIZE *
                                                          150,
                                                      width: IZIDimensions
                                                              .ONE_UNIT_SIZE *
                                                          150,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: IZIDimensions
                                                          .SPACE_SIZE_3X,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .listProducts[
                                                                    index]
                                                                .name!,
                                                            style: TextStyle(
                                                              color:
                                                                  ColorResources
                                                                      .BLACK,
                                                              fontFamily:
                                                                  NUNITO,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  IZIDimensions
                                                                      .FONT_SIZE_H5,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: IZIDimensions
                                                                .SPACE_SIZE_1X,
                                                          ),
                                                          Text(
                                                            '${controller.listProducts[index].sold!} đã bán',
                                                            style: TextStyle(
                                                              color:
                                                                  ColorResources
                                                                      .GREY,
                                                              fontFamily:
                                                                  NUNITO,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  IZIDimensions
                                                                      .FONT_SIZE_DEFAULT,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: IZIDimensions
                                                                .SPACE_SIZE_1X,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${IZIPrice.currencyConverterVND(controller.listProducts[index].price!.toDouble())}đ',
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorResources
                                                                      .colorMain,
                                                                  fontFamily:
                                                                      NUNITO,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      IZIDimensions
                                                                          .FONT_SIZE_H6,
                                                                ),
                                                              ),
                                                              // click add to cart
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller.addCart(
                                                                      controller
                                                                              .listProducts[
                                                                          index]);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.all(
                                                                      IZIDimensions
                                                                              .SPACE_SIZE_1X *
                                                                          0.5),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(IZIDimensions
                                                                              .BORDER_RADIUS_2X),
                                                                      color: ColorResources
                                                                          .colorMain),
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: ColorResources
                                                                        .WHITE,
                                                                    size: IZIDimensions
                                                                            .ONE_UNIT_SIZE *
                                                                        30,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: IZIDimensions
                                                      .SPACE_SIZE_1X,
                                                ),
                                                const Divider(),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              );
      },
    );
  }

  Widget _floattingButton(DetailFoodController controller) {
    return FloatingActionButton(
        backgroundColor: ColorResources.WHITE,
        onPressed: () {
          controller.gotoCard();
        },
        child: Container(
          child: controller.listProductsCard.isEmpty
              ? Icon(
                  Icons.shopping_cart,
                  size: IZIDimensions.ONE_UNIT_SIZE * 40,
                  color: ColorResources.RED,
                )
              : Badge(
                  badgeContent: Text(
                    controller.listProductsCard.length.toString(),
                    style: TextStyle(
                      color: ColorResources.WHITE,
                      fontFamily: NUNITO,
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: IZIDimensions.ONE_UNIT_SIZE * 40,
                    color: ColorResources.RED,
                  ),
                ),
        ));
  }

  Widget _imageSlider(DetailFoodController controller) {
    return Stack(
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
              controller.productsModel!.image!.length,
              (index) => ClipRRect(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BORDER_RADIUS_2X),
                    child: IZIImage(controller.productsModel!.image![index]),
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
              padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color.fromRGBO(0, 0, 0, 0.3)),
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
                borderRadius:
                    BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                color: const Color.fromRGBO(0, 0, 0, 0.3)),
            child: Center(
              child: Text(
                '${controller.currentIndex + 1}/${controller.productsModel!.image!.length}',
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
    );
  }

  ///
  /// bottom sheet
  ///
  Widget _bottomSheet() {
    return GetBuilder(
      init: DetailFoodController(),
      builder: (DetailFoodController controller) => Container(
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
                    border:
                        Border.all(width: 1, color: ColorResources.colorMain)),
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
                    child: Icon(
                      Icons.shopping_cart,
                      size: IZIDimensions.ONE_UNIT_SIZE * 40,
                      color: ColorResources.colorMain,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_3X,
            ),
            // button pay ment
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  controller.gotoPayment();
                },
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
            ),
          ],
        ),
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
