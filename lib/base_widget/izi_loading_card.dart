// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
        itemCount: 10, // Số lượng item
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0), // Khoảng cách giữa các item
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.white, // Màu nền của hình ảnh
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 80,
                    height: 16,
                    color: Colors.white, // Màu nền của tiêu đề
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 120,
                    height: 12,
                    color: Colors.white, // Màu nền của văn bản dưới cùng
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




  

