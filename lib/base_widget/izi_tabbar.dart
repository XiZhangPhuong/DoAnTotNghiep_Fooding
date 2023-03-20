import 'package:flutter/material.dart';

import '../helper/izi_dimensions.dart';
import '../utils/color_resources.dart';

class IZITabBar<T> extends StatelessWidget {
  const IZITabBar({
    Key? key,
    required this.items,
    required this.onTapChangedTabbar,
    this.currentIndex = 0,
    this.onTap,
    this.heightTabView,
    this.widthTabBar,
    this.heightTabBar,
    this.colorTabBar,
    this.disibleColorTabBar,
    this.radiusTabBar,
    this.isUnderLine = true,
    this.colorText,
    this.disbleColorText,
    this.colorUnderLine,
    this.colorBackground,
  }) : super(key: key);

  final List<T> items;
  final int? currentIndex;
  final Function? onTap;
  final Function(int index) onTapChangedTabbar;
  final double? heightTabView;
  final double? widthTabBar;
  final Color? colorTabBar;
  final Color? disibleColorTabBar;
  final double? radiusTabBar;
  final bool? isUnderLine;
  final double? heightTabBar;
  final Color? colorText;
  final Color? disbleColorText;
  final Color? colorUnderLine;
  final Color? colorBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: heightTabBar ?? IZIDimensions.ONE_UNIT_SIZE * 60,
      decoration: BoxDecoration(
        color: colorBackground ?? ColorResources.BACK_GROUND,
        borderRadius: BorderRadius.circular(
          radiusTabBar ?? 0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () {
                onTapChangedTabbar(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 10,
                ),
                height: double.infinity,
                width: widthTabBar != null
                    ? (widthTabBar!.roundToDouble() / (items.length + .5))
                    : IZIDimensions.ONE_UNIT_SIZE * 580.roundToDouble() / (items.length + .5),
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? colorTabBar ?? ColorResources.BACK_GROUND
                      : disibleColorTabBar ?? ColorResources.BACK_GROUND,
                  borderRadius: !isUnderLine!
                      ? BorderRadius.circular(
                          radiusTabBar ?? IZIDimensions.BLUR_RADIUS_3X,
                        )
                      : null,
                  border: isUnderLine!
                      ? Border(
                          bottom: currentIndex == index
                              ? BorderSide(
                                  width: IZIDimensions.ONE_UNIT_SIZE * 5,
                                  color: colorUnderLine ?? ColorResources.PRIMARY_4,
                                )
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    items[index].toString(),
                    style: TextStyle(
                      color: currentIndex == index
                          ? colorText ?? ColorResources.PRIMARY_4
                          : disbleColorText ?? ColorResources.colorTextTabbar,
                      fontWeight: currentIndex == index ? FontWeight.bold : FontWeight.bold,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IZITabBarScroll<T> extends StatelessWidget {
  const IZITabBarScroll({
    Key? key,
    required this.items,
    required this.onTapChangedTabbar,
    this.currentIndex = 0,
    this.onTap,
    this.heightTabView,
    this.widthTabBar,
    this.heightTabBar,
    this.colorTabBar,
    this.disibleColorTabBar,
    this.radiusTabBar,
    this.isUnderLine = true,
    this.colorText,
    this.disbleColorText,
    this.colorUnderLine,
    this.colorBackground,
  }) : super(key: key);

  final List<T> items;
  final int? currentIndex;
  final Function? onTap;
  final Function(int index) onTapChangedTabbar;
  final double? heightTabView;
  final double? widthTabBar;
  final Color? colorTabBar;
  final Color? disibleColorTabBar;
  final double? radiusTabBar;
  final bool? isUnderLine;
  final double? heightTabBar;
  final Color? colorText;
  final Color? disbleColorText;
  final Color? colorUnderLine;
  final Color? colorBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: double.infinity,
        height: heightTabBar ?? IZIDimensions.ONE_UNIT_SIZE * 60,
        decoration: BoxDecoration(
          color: colorBackground ?? ColorResources.BACK_GROUND,
          borderRadius: BorderRadius.circular(
            radiusTabBar ?? 0,
          ),
        ),
        child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onTapChangedTabbar(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 10,
                ),
                height: double.infinity,
                width: IZIDimensions.ONE_UNIT_SIZE * 130.roundToDouble(),
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? colorTabBar ?? ColorResources.BACK_GROUND
                      : disibleColorTabBar ?? ColorResources.BACK_GROUND,
                  borderRadius: !isUnderLine!
                      ? BorderRadius.circular(
                          radiusTabBar ?? IZIDimensions.BLUR_RADIUS_3X,
                        )
                      : null,
                  border: isUnderLine!
                      ? Border(
                          bottom: currentIndex == index
                              ? BorderSide(
                                  width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                  color: colorUnderLine ?? ColorResources.PRIMARY_4,
                                )
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    items[index].toString(),
                    style: TextStyle(
                      color:
                          currentIndex == index ? colorText ?? ColorResources.PRIMARY_4 : disbleColorText ?? ColorResources.GREY,
                      fontWeight: currentIndex == index ? FontWeight.w600 : FontWeight.normal,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        )
        // SingleChildScrollView(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       ...List.generate(
        //         items.length,
        //         (index) =>
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
