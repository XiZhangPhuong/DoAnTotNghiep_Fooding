import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SafeArea(
      top: false,
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_1X,
              right: IZIDimensions.SPACE_SIZE_1X,
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            height: IZIDimensions.ONE_UNIT_SIZE * 100,
            width: IZIDimensions.ONE_UNIT_SIZE * 100,
            decoration: const BoxDecoration(
              color: ColorResources.WHITE,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: IZIDimensions.SPACE_SIZE_1X * 1.5,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: ColorResources.colorTextTabbar,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 16, right: 16),
              child: Image.asset('assets/images/helpImage.png'),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Tôi có thể giúp gì cho bạn?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isLightMode ? Colors.black : Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Bạn đang cần sự giúp đỡ ư\nvui lòng liên hệ cho tôi phía dưới.\nChúng tôi giúp đỡ bạn nhiệt tình và nhanh nhất',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: isLightMode ? Colors.black : Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                      width: 140,
                      height: 40,
                      margin: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_3X,
                        left: IZIDimensions.SPACE_SIZE_5X,
                        right: IZIDimensions.SPACE_SIZE_5X,
                      ),
                      decoration: BoxDecoration(
                        color: isLightMode ? Colors.blue : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                index == 0
                                    ? 'Hotline: 19000098'
                                    : index == 1
                                        ? "Gmail: admin@foodDelivery.com"
                                        : "Facebook: FoodDeliveryPAGE",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isLightMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
