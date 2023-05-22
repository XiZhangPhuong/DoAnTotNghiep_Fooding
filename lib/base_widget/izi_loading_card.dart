// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/izi_dimensions.dart';
import '../utils/color_resources.dart';

class CardLoading extends StatelessWidget {
  const CardLoading({
    Key? key,
    this.count,
  }) : super(key: key);
  final int? count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        padding: EdgeInsets.only(
          top: IZIDimensions.SPACE_SIZE_2X,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          // crossAxisCount: count ?? 2,
          maxCrossAxisExtent: 80,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: count ?? 10,
        itemBuilder: (BuildContext ctx, index) {
          return Shimmer.fromColors(
            baseColor: ColorResources.NEUTRALS_6,
            highlightColor: Colors.grey.withOpacity(0.2),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_2X,
              ),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_2X,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardLoadingItem extends StatelessWidget {
  const CardLoadingItem({
    Key? key,
    this.count = 2,
    this.height = 70,
  }) : super(key: key);
  final int? count;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count ?? 2,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            vertical: IZIDimensions.SPACE_SIZE_1X,
            horizontal: IZIDimensions.HORIZONTAL_SCREEN,
          ),
          padding: const EdgeInsets.only(
            right: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              IZIDimensions.BORDER_RADIUS_4X,
            ),
          ),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Container(
                  height: height ?? 70,
                  width: height ?? 70,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_2X,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.4),
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        height: 10,
                        width: IZIDimensions.iziSize.width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: ColorResources.NEUTRALS_6,
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        height: 10,
                        width: IZIDimensions.iziSize.width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: ColorResources.NEUTRALS_6,
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        height: 10,
                        width: IZIDimensions.iziSize.width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CardLoadingList extends StatelessWidget {
  const CardLoadingList({
    Key? key,
    this.count = 10,
    this.height = 220,
  }) : super(key: key);
  final int? count;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count ?? 10,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: ColorResources.NEUTRALS_6,
                  highlightColor: Colors.grey.withOpacity(0.2),
                  child: Container(
                    height: height ?? 220,
                    width: height ?? 220,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_2X,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DataEmpty extends StatelessWidget {
  const DataEmpty({Key? key, this.lable}) : super(key: key);
  final String? lable;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        lable ?? "Không có dữ liệu",
        style: TextStyle(
          color: ColorResources.NEUTRALS_5,
          fontSize: IZIDimensions.FONT_SIZE_H5,
        ),
      ),
    );
  }
}

class CardLoadingText extends StatelessWidget {
  const CardLoadingText({
    Key? key,
    this.count = 2,
    this.height = 70,
  }) : super(key: key);
  final int? count;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count ?? 2,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            vertical: IZIDimensions.SPACE_SIZE_1X,
            horizontal: IZIDimensions.HORIZONTAL_SCREEN,
          ),
          padding: const EdgeInsets.only(
            right: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              IZIDimensions.BORDER_RADIUS_4X,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Container(
                  height: 10,
                  width: IZIDimensions.iziSize.width,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: ColorResources.NEUTRALS_6,
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Container(
                  height: 10,
                  width: IZIDimensions.iziSize.width,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: ColorResources.NEUTRALS_6,
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Container(
                  height: 10,
                  width: IZIDimensions.iziSize.width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ShimmerCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 1.0, // Tỷ lệ chiều rộng/chiều cao của mỗi item
      padding: EdgeInsets.all(8.0), // Khoảng cách giữa các item
      children: List.generate(8, (index) {
        return Container(
          padding: EdgeInsets.all(8.0), // Khoảng cách bên trong mỗi item
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Container(color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: 60,
                  height: 8,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ShimmerListCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 80,
                    height: 16,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 120,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

///
/// simmer detail product
///
class SimmerDetailProduct extends StatefulWidget {
  const SimmerDetailProduct({super.key});

  @override
  State<SimmerDetailProduct> createState() => _SimmerDetailProductState();
}

class _SimmerDetailProductState extends State<SimmerDetailProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BLUR_RADIUS_3X),
                    color: ColorResources.WHITE,
                  ),
                  height: IZIDimensions.ONE_UNIT_SIZE * 300,
                  width: IZIDimensions.iziSize.width,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_3X,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_2X,
                    right: IZIDimensions.SPACE_SIZE_2X),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: IZIDimensions.ONE_UNIT_SIZE * 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.SPACE_SIZE_2X),
                          color: ColorResources.WHITE,
                        ),
                        width: IZIDimensions.iziSize.width * 0.45,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Icon(Icons.favorite),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_1X,
              ),
              Container(
                padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: IZIDimensions.ONE_UNIT_SIZE * 15,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.SPACE_SIZE_2X),
                      color: ColorResources.WHITE,
                    ),
                    width: IZIDimensions.iziSize.width * 0.6,
                  ),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_1X,
              ),
              // rating bar
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: IZIDimensions.ONE_UNIT_SIZE * 20,
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      RatingStars(
                        value: 5,
                        maxValue: 5,
                      ),
                      SizedBox(
                        width: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      Container(
                        height: IZIDimensions.ONE_UNIT_SIZE * 20,
                        width: IZIDimensions.iziSize.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                IZIDimensions.SPACE_SIZE_3X),
                            color: ColorResources.WHITE),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              const Divider(),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: IZIDimensions.ONE_UNIT_SIZE * 60,
                        width: IZIDimensions.ONE_UNIT_SIZE * 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.WHITE,
                        ),
                      ),
                      SizedBox(
                        width: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 20,
                            width: IZIDimensions.ONE_UNIT_SIZE * 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.SPACE_SIZE_3X),
                                color: ColorResources.WHITE),
                          ),
                          SizedBox(
                            height: IZIDimensions.ONE_UNIT_SIZE * 10,
                          ),
                          Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 20,
                            width: IZIDimensions.ONE_UNIT_SIZE * 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.SPACE_SIZE_3X),
                                color: ColorResources.WHITE),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: IZIDimensions.ONE_UNIT_SIZE * 50,
                        width: IZIDimensions.ONE_UNIT_SIZE * 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                IZIDimensions.SPACE_SIZE_2X),
                            color: ColorResources.WHITE),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              const Divider(),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_2X),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: IZIDimensions.ONE_UNIT_SIZE * 20,
                        width: IZIDimensions.iziSize.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                IZIDimensions.SPACE_SIZE_3X),
                            color: ColorResources.WHITE),
                      ),
                      Container(
                        height: IZIDimensions.ONE_UNIT_SIZE * 20,
                        width: IZIDimensions.iziSize.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                IZIDimensions.SPACE_SIZE_3X),
                            color: ColorResources.WHITE),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_3X,
              ),
              const CardLoadingItem(
                count: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// simmer store page
///
class SimmerStorePage extends StatelessWidget {
  const SimmerStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: IZIDimensions.iziSize.width,
                alignment: Alignment.center,
                child: Container(
                  margin:
                      EdgeInsets.only(top: IZIDimensions.ONE_UNIT_SIZE * 100),
                  height: IZIDimensions.ONE_UNIT_SIZE * 250,
                  width: IZIDimensions.iziSize.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
                      color: ColorResources.WHITE),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_5X * 1.6),
                alignment: Alignment.centerLeft,
                child: Container(
                  height: IZIDimensions.ONE_UNIT_SIZE * 20,
                  width: IZIDimensions.iziSize.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
                      color: ColorResources.WHITE),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_5X * 1.6),
                child: Row(
                  children: [
                    IZIImage(
                      ImagesPath.icon_star,
                      width: IZIDimensions.ONE_UNIT_SIZE * 50,
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Container(
                      height: IZIDimensions.ONE_UNIT_SIZE * 20,
                      width: IZIDimensions.iziSize.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.SPACE_SIZE_3X),
                          color: ColorResources.WHITE),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Container(
                      height: IZIDimensions.ONE_UNIT_SIZE * 20,
                      width: IZIDimensions.iziSize.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.SPACE_SIZE_3X),
                          color: ColorResources.WHITE),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_2X),
                    height: IZIDimensions.ONE_UNIT_SIZE * 20,
                    width: IZIDimensions.iziSize.width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
                        color: ColorResources.WHITE),
                  ),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                          child: Column(
                          
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        IZIDimensions.SPACE_SIZE_2X),
                                    child: IZIImage(
                                      '',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                     
                                      children: [
                                        Container(
                                          height:
                                              IZIDimensions.ONE_UNIT_SIZE * 20,
                                          width:
                                              IZIDimensions.iziSize.width * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      IZIDimensions
                                                          .SPACE_SIZE_3X),
                                              color: ColorResources.WHITE),
                                        ),
                                        SizedBox(
                                          height: IZIDimensions.SPACE_SIZE_2X,
                                        ),
                                        Container(
                                          height:
                                              IZIDimensions.ONE_UNIT_SIZE * 20,
                                          width:
                                              IZIDimensions.iziSize.width * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      IZIDimensions
                                                          .SPACE_SIZE_3X),
                                              color: ColorResources.WHITE),
                                        ),
                                        SizedBox(
                                          height: IZIDimensions.SPACE_SIZE_1X,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      20,
                                              width:
                                                  IZIDimensions.iziSize.width *
                                                      0.2,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          IZIDimensions
                                                              .SPACE_SIZE_3X),
                                                  color: ColorResources.WHITE),
                                            ),
                                            // click add to cart
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    IZIDimensions
                                                            .SPACE_SIZE_1X *
                                                        0.5),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(IZIDimensions
                                                            .BORDER_RADIUS_2X),
                                                    color: ColorResources
                                                        .colorMain),
                                                child: Icon(
                                                  Icons.add,
                                                  color: ColorResources.WHITE,
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
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
