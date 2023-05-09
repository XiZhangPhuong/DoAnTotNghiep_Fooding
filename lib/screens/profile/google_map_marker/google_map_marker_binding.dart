import 'package:fooding_project/screens/profile/google_map_marker/google_map_marker_controller.dart';
import 'package:get/get.dart';

class GoogleMapMarkerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoogleMapMarkerController>(() => GoogleMapMarkerController());
  }
}
