import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/screens/favorite/favorite_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FavoriteController(),
      builder: (FavoriteController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          body: controller.isLoadingFavorites == false
              ? const CardLoadingItem(
                  count: 10,
                )
              : controller.listProductFavorite.isEmpty
                  ? const DataEmpty()
                  : SafeArea(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_2X,
                              vertical: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Items (${controller.listProductFavorite.length})',
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w600,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.clickDeleteProduct(productRequest: Products());
                                    },
                                    child: Text(
                                      'Xóa tất cả',
                                      style: TextStyle(
                                        color: ColorResources.colorMain,
                                        fontFamily: NUNITO,
                                        fontWeight: FontWeight.w600,
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.listProductFavorite.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.gotoDetailFood(controller
                                          .listProductFavorite[index].id!);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          IZIDimensions.SPACE_SIZE_2X),
                                      margin: EdgeInsets.only(
                                          top: IZIDimensions.SPACE_SIZE_1X * 0,
                                          bottom: IZIDimensions.SPACE_SIZE_2X,
                                          left: IZIDimensions.SPACE_SIZE_3X,
                                          right: IZIDimensions.SPACE_SIZE_3X),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            IZIDimensions.BORDER_RADIUS_3X),
                                        color: ColorResources.WHITE,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        IZIDimensions
                                                            .BORDER_RADIUS_3X),
                                                child: IZIImage(
                                                  controller
                                                      .listProductFavorite[
                                                          index]
                                                      .image!
                                                      .first,
                                                  height: IZIDimensions
                                                          .ONE_UNIT_SIZE *
                                                      120,
                                                  width: IZIDimensions
                                                          .ONE_UNIT_SIZE *
                                                      120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    IZIDimensions.SPACE_SIZE_3X,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .listProductFavorite[
                                                                  index]
                                                              .name!,
                                                          style: TextStyle(
                                                            color:
                                                                ColorResources
                                                                    .BLACK,
                                                            fontFamily: NUNITO,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                IZIDimensions
                                                                    .FONT_SIZE_H5,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller.clickDeleteProduct(productRequest: controller.listProductFavorite[index]);
                                                          },
                                                          child: Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: IZIDimensions
                                                                      .ONE_UNIT_SIZE *
                                                                  40,
                                                              color:
                                                                  ColorResources
                                                                      .colorMain),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      controller.formatSold(
                                                          controller
                                                              .listProductFavorite[
                                                                  index]
                                                              .sold!),
                                                      style: TextStyle(
                                                        color:
                                                            ColorResources.GREY,
                                                        fontFamily: NUNITO,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: IZIDimensions
                                                            .FONT_SIZE_DEFAULT,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${IZIPrice.currencyConverterVND(controller.listProductFavorite[index].price!.toDouble())}đ',
                                                      style: TextStyle(
                                                        color: ColorResources
                                                            .colorMain,
                                                        fontFamily: NUNITO,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: IZIDimensions
                                                            .FONT_SIZE_H6,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
