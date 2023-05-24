import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/izi_tabbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/store/store_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart ' as badge;

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StoreController(),
      builder: (StoreController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          floatingActionButton: _floattingButton(controller),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: controller.isLoadDingStore == false
              ? const SimmerStorePage()
              : Column(
                  children: [
                    SizedBox(
                      height: IZIDimensions.ONE_UNIT_SIZE * 500,
                      child: Stack(
                        children: [
                          IZIImage(
                            IZIValidate.nullOrEmpty(
                                    controller.storeResponse.avatar)
                                ? ''
                                : controller.storeResponse.avatar!,
                            height: IZIDimensions.ONE_UNIT_SIZE * 350,
                          ),
                          // icon back
                          Positioned(
                            left: IZIDimensions.SPACE_SIZE_2X,
                            top: IZIDimensions.ONE_UNIT_SIZE * 50,
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
                          // infor Store
                          Positioned(
                            bottom: 0,
                            left: 32,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_5X)),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: IZIDimensions.SPACE_SIZE_2X,
                                ),
                                alignment: Alignment.center,
                                width: IZIDimensions.iziSize.width * 0.8,
                                height: IZIDimensions.ONE_UNIT_SIZE * 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        IZIDimensions.BORDER_RADIUS_5X),
                                    color: ColorResources.WHITE),
                                child: Column(
                                  children: [
                                    Text(
                                      'Đối tác của TPFOOD'.toUpperCase(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: const Color(0xff29878A),
                                        fontFamily: NUNITO,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                      ),
                                    ),
                                    SizedBox(
                                      height: IZIDimensions.SPACE_SIZE_3X,
                                    ),
                                    Text(
                                      IZIValidate.nullOrEmpty(
                                              controller.storeResponse.fullName)
                                          ? ''
                                          : controller.storeResponse.fullName!
                                              .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorResources.BLACK,
                                        fontFamily: NUNITO,
                                        fontWeight: FontWeight.w600,
                                        fontSize: IZIDimensions.FONT_SIZE_H4,
                                      ),
                                    ),
                                    SizedBox(
                                      height: IZIDimensions.SPACE_SIZE_3X,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              IZIDimensions.SPACE_SIZE_2X),
                                      child: Text(
                                        IZIValidate.nullOrEmpty(controller
                                                .storeResponse.address)
                                            ? ''
                                            : '${controller.storeResponse.address!} - ${controller.distance}',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: ColorResources.GREY,
                                          fontFamily: NUNITO,
                                          fontWeight: FontWeight.w600,
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.showDiaLogCheckCallStore(phoneNumber: controller.isLoadDingStore==true ? controller.storeResponse.phone! : '');
                                      },
                                      child: Container(
                                        alignment: Alignment.bottomRight,
                                        padding: EdgeInsets.only(
                                          right: IZIDimensions.SPACE_SIZE_3X
                                        ),
                                        child: AvatarGlow(
                                          glowColor: ColorResources.colorMain,
                                          duration: const Duration(
                                            milliseconds: 700,
                                          ),
                                          endRadius:
                                              IZIDimensions.ONE_UNIT_SIZE * 30,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ColorResources.colorMain,
                                            child: Icon(
                                              Icons.phone,
                                              color: ColorResources.WHITE,
                                              size:
                                                  IZIDimensions.ONE_UNIT_SIZE * 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // check open hour
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_3X,
                          right: IZIDimensions.SPACE_SIZE_3X),
                      child: Row(
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
                            controller.checkOpeningHours(
                                controller.storeResponse.openHour!,
                                controller.storeResponse.closeHour!),
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w400,
                              decoration: controller
                                      .checkOpeningHours(
                                          controller.storeResponse.openHour!,
                                          controller.storeResponse.closeHour!)
                                      .contains('Đã đóng cửa')
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_3X,
                          right: IZIDimensions.SPACE_SIZE_3X),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: IZIDimensions.ONE_UNIT_SIZE * 50,
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Text(
                            '${controller.averRage1.toStringAsFixed(1)} ( ${controller.totalRating1}+ )',
                            maxLines: 1,
                            style: TextStyle(
                              color: ColorResources.GREY,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          Icon(
                            Icons.production_quantity_limits_sharp,
                            color: Colors.grey,
                            size: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Text(
                            '${controller.countSold} sp đã bán',
                            maxLines: 1,
                            style: TextStyle(
                              color: ColorResources.GREY,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_3X,
                    ),

                    // tabbar category store
                    IZITabBarScroll(
                      items: controller.listNameCategory,
                      currentIndex: controller.curenIndex,
                      onTapChangedTabbar: (index) {
                        controller.changeTabbar(index);
                      },
                      colorText: ColorResources.colorMain,
                      colorUnderLine: ColorResources.colorMain,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child:
                          // ignore: unrelated_type_equality_checks
                          controller.listProducts == false
                              ? const CardLoadingItem(
                                  count: 10,
                                )
                              : controller.listProducts.isEmpty
                                  ? const DataEmpty()
                                  : _listviewProducts(controller),
                    ))
                  ],
                ),
        );
      },
    );
  }
}

Widget _listviewProducts(StoreController controller) {
  return Visibility(
    visible: true,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listProducts.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.SPACE_SIZE_2X),
                      child: IZIImage(
                        controller.listProducts[index].image!.first,
                        height: IZIDimensions.ONE_UNIT_SIZE * 150,
                        width: IZIDimensions.ONE_UNIT_SIZE * 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.listProducts[index].name!,
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_H5,
                            ),
                          ),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Text(
                            controller.formatSold(
                                controller.listProducts[index].sold!),
                            style: TextStyle(
                              color: ColorResources.GREY,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.listProducts[index].priceDiscount==0 ? 
                                 '${IZIPrice.currencyConverterVND(controller.listProducts[index].price!.toDouble())}vnđ' : 
                                '${IZIPrice.currencyConverterVND(controller.listProducts[index].priceDiscount!.toDouble())}vnđ',
                                style: TextStyle(
                                  color: ColorResources.colorMain,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                              ),
                              // click add to cart
                              GestureDetector(
                                onTap: () {
                                  
                                  controller
                                      .addCart(controller.listProducts[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                      IZIDimensions.SPACE_SIZE_1X * 0.5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          IZIDimensions.BORDER_RADIUS_2X),
                                      color: ColorResources.colorMain),
                                  child: Icon(
                                    Icons.add,
                                    color: ColorResources.WHITE,
                                    size: IZIDimensions.ONE_UNIT_SIZE * 30,
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
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    ),
  );
}

///
/// floatting button cart
///
Widget _floattingButton(StoreController controller) {
  return controller.countCart == 0
      ? Container()
      : FloatingActionButton(
          backgroundColor: ColorResources.WHITE,
          onPressed: () {
            controller.gotoCart();
          },
          child: badge.Badge(
            badgeContent: controller.isLoadingCountCart == false
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    controller.countCart.toString(),
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
        );
}
