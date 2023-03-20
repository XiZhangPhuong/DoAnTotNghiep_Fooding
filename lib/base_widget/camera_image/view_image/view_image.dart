import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../helper/izi_dimensions.dart';
import '../../../utils/color_resources.dart';
import '../../izi_image.dart';

// ignore: avoid_classes_with_only_static_members
class ViewImage {
  ///
  /// Show view image.
  ///
  static void showViewImage({
    required List<String> images,
    required int index,
    required DisplayImageType type,
    required List<File> files,
  }) {
    Get.dialog(
      ViewImageWidget(
        images: images,
        files: files,
        index: index,
        type: type,
      ),
    );
  }
}

enum DisplayImageType {
  IMAGE,
  FILE,
}

class ViewImageWidget extends StatefulWidget {
  ViewImageWidget({
    Key? key,
    this.images,
    this.files,
    required this.index,
    required this.type,
  }) : super(key: key);

  List<String>? images;
  List<File>? files;
  final int index;
  final DisplayImageType type;

  @override
  State<ViewImageWidget> createState() => _ViewImageWidgetState();
}

class _ViewImageWidgetState extends State<ViewImageWidget> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Get default view image.
    currentIndex = widget.index;
    setState(() {});
    _pageController = PageController(initialPage: widget.index);
  }

  ///
  /// Generate view image.
  ///
  Widget generateViewImage(DisplayImageType type, int index) {
    if (type == DisplayImageType.FILE) {
      return IZIImage.file(
        widget.files![index],
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        fit: BoxFit.contain,
      );
    }
    return IZIImage(
      widget.images![index].toString(),
      width: IZIDimensions.iziSize.width,
      height: IZIDimensions.iziSize.height,
      fit: BoxFit.contain,
    );
  }

  ///
  /// Generate item count.
  ///
  int generateItemCount(DisplayImageType type) {
    if (type == DisplayImageType.FILE) {
      return widget.files!.length;
    }
    return widget.images!.length;
  }

  ///
  /// Generate  string.
  ///
  String generateString(DisplayImageType type) {
    if (type == DisplayImageType.FILE) {
      return '${currentIndex + 1}/${widget.files!.length}';
    }
    return '${currentIndex + 1}/${widget.images!.length}';
  }

  ///
  /// On page change.
  ///
  void onPageChange(int index) {
    if (!mounted) return;
    if (mounted) {
      currentIndex = index;
      setState(() {});
    }
  }

  ///
  /// On next page.
  ///
  void _nextPage() {
    _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  ///
  ///
  ///
  void _prevPage() {
    _pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black,
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.width,
            child: PageView.builder(
              onPageChanged: (index) {
                onPageChange(index);
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: generateItemCount(widget.type),
              controller: _pageController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onHorizontalDragUpdate: (value) {
                    if (value.delta.dx < -7.5 && value.delta.dy == 0) {
                      _nextPage();
                    } else if (value.delta.dx > 7.5 && value.delta.dy == 0) {
                      _prevPage();
                    }
                  },
                  child: Container(
                    width: IZIDimensions.iziSize.width,
                    height: IZIDimensions.iziSize.height,
                    color: Colors.black,
                    child: SafeArea(
                      child: InteractiveViewer(
                        maxScale: 9,
                        child: generateViewImage(widget.type, index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: SizedBox(
            width: IZIDimensions.iziSize.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: IZIDimensions.SPACE_SIZE_1X,
                horizontal: IZIDimensions.HORIZONTAL_SCREEN,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: IZIDimensions.ONE_UNIT_SIZE * 60,
                          height: IZIDimensions.ONE_UNIT_SIZE * 60,
                          decoration: const BoxDecoration(
                            color: ColorResources.PRIMARY_1,
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: IZIDimensions.ONE_UNIT_SIZE * 18,
                                top: IZIDimensions.ONE_UNIT_SIZE * 15,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorResources.WHITE,
                                  size: IZIDimensions.ONE_UNIT_SIZE * 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _prevPage();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ColorResources.WHITE,
                          size: IZIDimensions.ONE_UNIT_SIZE * 40,
                        ),
                      ),
                      Text(
                        generateString(widget.type),
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.WHITE,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _nextPage();
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: ColorResources.WHITE,
                          size: IZIDimensions.ONE_UNIT_SIZE * 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
