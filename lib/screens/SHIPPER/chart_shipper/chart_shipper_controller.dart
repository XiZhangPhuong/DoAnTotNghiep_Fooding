import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/comment/comment_reponse.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class ChartShipperController extends GetxController {
  List<OrderResponse> listOrder = [];
  List<CommentRequets> listComment = [];
  List<User> listUser = [];
  bool isLoadingOrder = false;
  bool isLoadingComment = false;
  bool isLoadingUser = false;
  String idShipper = sl<SharedPreferenceHelper>().getIdUser;
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();
  final CommentRepostitory _commentRepostitory =
      GetIt.I.get<CommentRepostitory>();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();

  //

  double totalStar = 0;
  int totalRating = 0;
  double average = 0;
  @override
  void onInit() {
    super.onInit();
    allAllOrder();
    getListComment();
  }

  ///
  /// get all order
  ///
  Future<void> allAllOrder() async {
    _orderResponsitory.getAllOrder(
      idUser: idShipper,
      onSuccess: (data) {
        listOrder = data;
        isLoadingOrder = true;
        update();
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ////
  ///  get all Comment
  ///
  Future<void> getListComment() async {
    _commentRepostitory.getAllComment(
      onSucess: (data) {
        listComment = data;
        for (final i in data) {
          totalStar += i.rating!;
        }
        totalRating = data.length;
        average = totalStar / totalRating;
        getAllUser();
        isLoadingComment = true;
        update();
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ///
  /// get all User by id
  ///
  void getAllUser() {
    _userRepository.getAllCustommer(
      onSuccess: (data) {
        for (final i in listComment) {
          for (final j in data) {
            if (i.idUser == j.id) {
              listUser.add(j);
              break;
            }
          }
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// show bottomSheet evaluate
  ///
  void showDialogEvaluate() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
      height: IZIDimensions.iziSize.height / 1.5,
      decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
            topRight: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
          )),
      child: Column(
        children: [
          Text(
            'Tất cả đánh giá',
            style: TextStyle(
              color: ColorResources.BLACK,
              fontFamily: NUNITO,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H4,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listComment.length,
            itemBuilder: (context, index) {
              final itemComment = listComment[index];
              final itemUser = listUser[index];
              return GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 0.3,
                  child: Container(
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: IZIImage(
                                IZIValidate.nullOrEmpty(itemUser.avatar)
                                    ? 'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg'
                                    : itemUser.avatar!,
                                height: IZIDimensions.ONE_UNIT_SIZE * 50,
                                width: IZIDimensions.ONE_UNIT_SIZE * 50,
                              ),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  IZIValidate.nullOrEmpty(itemUser.fullName)
                                      ? 'TerryChang'
                                      : itemUser.fullName!,
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w600,
                                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                  ),
                                ),
                                SizedBox(
                                  height: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                RatingStars(
                                  value: itemComment.rating!.toDouble(),
                                  starCount: 5,
                                  starSize: IZIDimensions.ONE_UNIT_SIZE * 25,
                                  starColor: Colors.yellow,
                                  maxValueVisibility: false,
                                  valueLabelVisibility: false,
                                  onValueChanged: (value) {},
                                ),
                                SizedBox(
                                  height: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                Text(
                                  IZIValidate.nullOrEmpty(itemComment.content)
                                      ? ''
                                      : itemComment.content!,
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        IZIDimensions.FONT_SIZE_SPAN_SMALL,
                                  ),
                                ),
                                // image list comment
                              ],
                            ),
                            const Spacer(),
                            Text(
                              IZIValidate.nullOrEmpty(itemComment.timeComment)
                                  ? ''
                                  : itemComment.timeComment!,
                              style: TextStyle(
                                color: ColorResources.GREY,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    IZIDimensions.FONT_SIZE_SPAN_SMALL * 0.9,
                              ),
                            ),
                          ],
                        ),
                        IZIValidate.nullOrEmpty(listComment[index].listImage)
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(
                                    left: IZIDimensions.ONE_UNIT_SIZE * 70),
                                height: IZIDimensions.ONE_UNIT_SIZE * 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: itemComment.listImage!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          right: IZIDimensions.SPACE_SIZE_1X),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            IZIDimensions.BLUR_RADIUS_2X),
                                        child: IZIImage(
                                          itemComment.listImage![index],
                                          height:
                                              IZIDimensions.ONE_UNIT_SIZE * 50,
                                          width:
                                              IZIDimensions.ONE_UNIT_SIZE * 50,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    ));
  }
}
