import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/QNA365/homework_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

class HomeWorkPage extends GetView<HomeWorkController> {
  const HomeWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeWorkController(),
      builder: (HomeWorkController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            IZIDimensions.BORDER_RADIUS_7X * 1.3),
                        bottomRight: Radius.circular(
                            IZIDimensions.BORDER_RADIUS_7X * 1.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        // information
                        Container(
                          padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                          decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    IZIDimensions.BORDER_RADIUS_7X * 0),
                                bottomRight: Radius.circular(
                                    IZIDimensions.BORDER_RADIUS_7X * 0),
                              )),
                          child: Row(
                            children: [
                              ClipOval(
                                child: IZIImage(
                                  'https://scontent.fsgn2-4.fna.fbcdn.net/v/t39.30808-6/351147318_198641776008793_7850098912832806460_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=730e14&_nc_ohc=kVsiSmeCOu0AX_oas43&_nc_ht=scontent.fsgn2-4.fna&oh=00_AfDqyp78ohlvvPriIGyyAiJ74bccZnU3UTfcLKMYZG1Dzg&oe=648180E4',
                                  height: IZIDimensions.ONE_UNIT_SIZE * 70,
                                  width: IZIDimensions.ONE_UNIT_SIZE * 70,
                                ),
                              ),
                              SizedBox(
                                width: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Xin chào!',
                                    style: TextStyle(
                                      color: ColorResources.BLACK,
                                      fontFamily: NUNITO,
                                      fontSize:
                                          IZIDimensions.FONT_SIZE_SPAN_SMALL,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Phạm Văn Phương',
                                    style: TextStyle(
                                      color: ColorResources.BLACK,
                                      fontFamily: NUNITO,
                                      fontSize:
                                          IZIDimensions.FONT_SIZE_SPAN_SMALL,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding:
                                    EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[100],
                                ),
                                child: IZIImage(
                                  ImagesPath.helpAlert,
                                  height: IZIDimensions.ONE_UNIT_SIZE * 30,
                                  width: IZIDimensions.ONE_UNIT_SIZE * 30,
                                ),
                              ),
                              SizedBox(
                                width: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100],
                                ),
                                child: Badge.count(
                                  count: 3,
                                  child: Icon(
                                    Icons.notifications_none,
                                    color: Colors.black,
                                    size: IZIDimensions.ONE_UNIT_SIZE * 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // làm nhiệm vụ
                        _lamNhiemVu(),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Text(
                          'Bạn đang có câu hỏi cần \n giải đáp ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: NUNITO,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        // tao cau hoi

                        _taoCauHoi(),
                      ],
                    )),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Row(
                    children: [
                      // chon ngon ngu
                      _chonNgonNgu(controller),
                    ],
                  ),
                ),
                _listView(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  /// choose Language
  ///
  Widget _chonNgonNgu(HomeWorkController controller) => GestureDetector(
        onTap: () {
          controller.showDiaLogLanGuaGe();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: IZIDimensions.SPACE_SIZE_1X,
            horizontal: IZIDimensions.SPACE_SIZE_2X,
          ),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
              border: Border.all(width: 1, color: Colors.blue),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VietNamese',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: NUNITO,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                    size: IZIDimensions.ONE_UNIT_SIZE * 25,
                  ))
            ],
          ),
        ),
      );

  ///
  /// tao cau hoi
  ///
  Widget _taoCauHoi() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: IZIDimensions.ONE_UNIT_SIZE * 200,
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_3X,
          vertical: IZIDimensions.SPACE_SIZE_1X,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_2X),
            color: Colors.orange.withOpacity(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: IZIDimensions.ONE_UNIT_SIZE * 25,
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_2X,
            ),
            Text(
              'Tạo câu hỏi',
              style: TextStyle(
                color: ColorResources.WHITE,
                fontFamily: NUNITO,
                fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// LÀM NHIỆM VỤ
  ///
  Widget _lamNhiemVu() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.orange.withOpacity(0.2),
              Colors.orange.withOpacity(0.8)
            ]),
        borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_3X),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thu thập cơn mưa điểm bằng cách',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: NUNITO,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
                Row(
                  children: [
                    IZIImage(
                      ImagesPath.emptyCart,
                      height: IZIDimensions.ONE_UNIT_SIZE * 30,
                      width: IZIDimensions.ONE_UNIT_SIZE * 30,
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_3X,
                        vertical: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_7X),
                        border: Border.all(width: 2, color: Colors.white),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          'Làm nhiệm vụ',
                          style: TextStyle(
                            color: ColorResources.WHITE,
                            fontFamily: NUNITO,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: IZIImage(
              ImagesPath.emptyCart,
              height: IZIDimensions.ONE_UNIT_SIZE * 100,
              width: IZIDimensions.ONE_UNIT_SIZE * 100,
            ),
          ))
        ],
      ),
    );
  }
}

///
/// ListView
///

Widget _listView(HomeWorkController controller) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
      padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.listQuestion.length,
        itemBuilder: (context, index) {
          final item = controller.listQuestion[index];
          return Container(
            padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(IZIDimensions.BORDER_RADIUS_2X),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                  child: IZIImage(
                    item['avatar'].toString(),
                    height: IZIDimensions.ONE_UNIT_SIZE * 50,
                    width: IZIDimensions.ONE_UNIT_SIZE * 50,
                  ),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item['fullName'],
                              style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 7,
                            width: IZIDimensions.ONE_UNIT_SIZE * 7,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.BLACK),
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Text(
                            item['class'],
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontFamily: NUNITO,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                            ),
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 7,
                            width: IZIDimensions.ONE_UNIT_SIZE * 7,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.BLACK),
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Text(
                            item['subject'],
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontFamily: NUNITO,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                            ),
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Text(
                            item['score'],
                            style: TextStyle(
                              color: Colors.orange,
                              fontFamily: NUNITO,
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
                          Text(
                            item['time'],
                            style: TextStyle(
                                color: ColorResources.GREY,
                                fontFamily: NUNITO,
                                fontSize:
                                    IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.8),
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          item['asking'] == false
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          IZIDimensions.BLUR_RADIUS_1X),
                                      color: Colors.green),
                                  padding: EdgeInsets.symmetric(
                                    vertical: IZIDimensions.SPACE_SIZE_1X * 0.5,
                                    horizontal: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    'Lần đầu hỏi',
                                    style: TextStyle(
                                        color: ColorResources.WHITE,
                                        fontFamily: NUNITO,
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_SPAN_SMALL *
                                                0.65),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      Text(
                        item['content'],
                        style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: NUNITO,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.8),
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_1X * 0.5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: List.generate(
                                item['listAvatarReply'].length,
                                (index1) => ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_3X),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: IZIDimensions.SPACE_SIZE_1X * 0.5),
                                    child: IZIImage(
                                      '',
                                      height: IZIDimensions.ONE_UNIT_SIZE * 30,
                                      width: IZIDimensions.ONE_UNIT_SIZE * 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: IZIDimensions.SPACE_SIZE_4X,
                                vertical: IZIDimensions.SPACE_SIZE_1X),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.BORDER_RADIUS_7X),
                                color: Colors.blue),
                            child: Text(
                              'Trả lời',
                              style: TextStyle(
                                  color: ColorResources.WHITE,
                                  fontFamily: NUNITO,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL *
                                      0.85),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    ),
  );
}
