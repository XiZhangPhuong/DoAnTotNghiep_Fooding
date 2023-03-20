import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';


import '../helper/izi_dimensions.dart';
import '../helper/izi_size.dart';
import '../helper/izi_text_style.dart';
import '../utils/color_resources.dart';
import '../utils/internet_connection.dart';
import 'izi_image.dart';

class IZIScreen extends StatelessWidget {
  const IZIScreen(
      {Key? key,
      required this.body,
      this.background,
      this.appBar,
      this.isSingleChildScrollView = true,
      this.tabBar,
      this.widgetBottomSheet,
      this.drawer,
      this.safeAreaTop = true,
      this.safeAreaBottom = true,
      this.isBottomInset = false,
      this.floattingWidget})
      : super(key: key);

  final Widget body;
  final Widget? background;
  final Widget? appBar;
  final Widget? tabBar;
  final Widget? widgetBottomSheet;
  final bool? isSingleChildScrollView;
  final Widget? drawer;
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  final bool? isBottomInset;
  final Widget? floattingWidget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: unnecessary_parenthesis
      onTap: (() {
        FocusManager.instance.primaryFocus!.unfocus();
      }),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Obx(() {
          if (GetIt.I<InternetConnection>().getConnnectionStatus ==
              CONNECTION_STATUS.DISCONNECTED) {
            return Builder(
              builder: (context) {
                return Container(
                  height: IZIDimensions.iziSize.height,
                  width: IZIDimensions.iziSize.width,
                  color: ColorResources.WHITE,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IZIImage(
                          'assets/images/internet.jpg',
                        ),
                        Text('Không có kết nối vui lòng thử lại',
                            style: textStyleH6),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Stack(
            children: [
              background ??
                  // Container(
                  //   // color: Colors.white,
                  // ),
                  // BackgroundWhite(),
                  Container(
                    color: ColorResources.NEUTRALS_7,
                  ),
              SafeArea(
                top: safeAreaTop!,
                bottom: safeAreaBottom!,
                child: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints constraints,
                  ) {
                    IZISize.update(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    );
                    return Scaffold(
                      key: key,
                      // drawer: drawer,
                      resizeToAvoidBottomInset: isBottomInset,
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: [
                          appBar ?? const SizedBox(),
                          if (isSingleChildScrollView!)
                            Expanded(
                              //TODO: Thêm optional cho SingleScrollView
                              child: SingleChildScrollView(
                                child: body,
                              ),
                            )
                          else
                            Expanded(
                              child: body,
                            ),
                        ],
                      ),
                      endDrawer: drawer,
                      onEndDrawerChanged: (val) {
                        print("ABC");
                      },

                      bottomSheet: widgetBottomSheet ?? const SizedBox(),
                      floatingActionButton: floattingWidget,
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
