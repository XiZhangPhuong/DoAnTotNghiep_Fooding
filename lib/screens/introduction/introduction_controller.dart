import 'package:flutter/cupertino.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';

import '../../routes/routes_path/auth_routes.dart';
import '../../utils/images_path.dart';

class IntroductionController extends GetxController {
  //decalare data
  List<Map<String, dynamic>> introductionData = [
    {
      'image': ImagesPath.imageIntroduction1,
      'title': 'Tìm kiếm\nvà đặt đồ ăn',
      'content':
          'Khách hàng có thể sử dụng bất kì lúc nào, bất kì nơi đâu, thao tác dễ dàng, quan trọng nhất là độ bảo mật an toàn',
    },
    {
      'image': ImagesPath.imageIntroduction2,
      'title': 'Xem chi tiết\nlịch sử đặt hàng',
      'content':
          'Khách hàng có thể sử dụng bất kì lúc nào, bất kì nơi đâu, thao tác dễ dàng, quan trọng nhất là độ bảo mật an toàn',
    },
    {
      'image': ImagesPath.imageIntroduction3,
      'title': 'Đánh giá, phản hồi\ntrải nghiệm dịch vụ',
      'content':
          'Khách hàng có thể sử dụng bất kì lúc nào, bất kì nơi đâu, thao tác dễ dàng, quan trọng nhất là độ bảo mật an toàn'
    },
  ];
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  ///
  /// On change index of page view.
  ///
  void onChangePageIndex(int index) {
    currentIndex.value = index;
    if (currentIndex.value == introductionData.length) {
      Get.offAllNamed(AuthRoutes.LOGIN);
    }
    update();
  }

  ///
  /// on next page
  ///
  void onNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  ///
  /// On last page.
  ///
  void onLastPage() {
    pageController.jumpToPage(introductionData.length - 1);
  }

  ///
  /// on Auth Page
  ///
  void onAuthPage() {
    sl<SharedPreferenceHelper>().setSplash(status: true);
    Get.toNamed(AuthRoutes.LOGIN);
  }
}
