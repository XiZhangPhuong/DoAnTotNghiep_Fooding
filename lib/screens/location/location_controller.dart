import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/location/location_response.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../routes/routes_path/location_routes.dart';

class LocationController extends GetxController {
  //
  // declare API.
  UserRepository _userRepository = GetIt.I.get<UserRepository>();
  User user = User();
  List<LocationResponse> locations = [];
  bool isLoading = false;
  LocationResponse defaultLocation = LocationResponse();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUser();
  }

  ///
  /// Change addd Location page.
  ///
  void changeAddLocationPage() {
    Get.toNamed(
      LocationRoutes.ADDLOCATION,
    )?.then((value) => getAllLocation());
  }

  ///
  /// Change addd Location page.
  ///
  void changeEditLocationPage(int index) {
    Get.toNamed(
      LocationRoutes.EDITLOCATION,
      arguments: locations[index].id,
    )?.then((value) => getAllLocation());
  }

  ///
  /// Get user.
  ///
  Future<void> getUser() async {
    isLoading = true;
    user = await _userRepository.findUser();
    await getAllLocation();
  }

  ///
  /// Get all Location.
  ///
  Future<void> getAllLocation() async {
    locations.clear();
    _userRepository.getAllLocation(
      onSucces: (data) {
        for (final item in data) {
          if (item.id != user.idLocation) {
            locations.add(item);
          } else {
            defaultLocation = item;
          }
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  ///
  /// Choose Address.
  ///
  Future<void> chooseAddress(LocationResponse location) async {
    try {
      User request = User();
      request.idLocation = location.id;
      await _userRepository.updateUser(
          request, sl<SharedPreferenceHelper>().getIdUser);
      IZIAlert().success(message: "Cập nhật thành công");
      Get.back();
    } catch (e) {
      IZIAlert().error(message: "Cập nhật thất bại");
    }
  }
}
