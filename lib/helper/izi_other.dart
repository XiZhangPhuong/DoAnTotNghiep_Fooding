// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../utils/color_resources.dart';
import 'izi_dimensions.dart';
import 'izi_validate.dart';

class IZIOther {
  static const MethodChannel _channel = MethodChannel('app_settings');

  ///
  /// open link url
  ///
  static Future openLink({required String url}) async {
    if (!IZIValidate.nullOrEmpty(url)) {
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }

  static String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }

  static Future callPhone({required String phone}) async {
    // Check for phone call support
    if (await canLaunch(Platform.isIOS ? "tel://$phone" : "tel:$phone")) {
      await launch(Platform.isIOS ? "tel://$phone" : "tel:$phone");
    }
  }

  static void primaryFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> openAppSettings({
    bool asAnotherTask = false,
  }) async {
    _channel.invokeMethod('app_settings', {
      'asAnotherTask': asAnotherTask,
    });
  }

  /// Future async method call to open internal storage settings.
  static Future<void> openInternalStorageSettings({
    bool asAnotherTask = false,
  }) async {
    _channel.invokeMethod('internal_storage', {
      'asAnotherTask': asAnotherTask,
    });
  }

  // static Future<String> getIdentifierDevice() async {
  //   String identifier = '';
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       final build = await deviceInfoPlugin.androidInfo;
  //       identifier = build.androidId; //UUID for Android
  //     } else if (Platform.isIOS) {
  //       final data = await deviceInfoPlugin.iosInfo;
  //       identifier = data.identifierForVendor; //UUID for iOS
  //     }
  //   } on PlatformException {
  //     print('Failed to get platform version');
  //   }

  //   return identifier;
  // }

  static Future<Uint8List> resizeImage(String imageUrl) async {
    // ignore: unused_local_variable
    Uint8List targetlUinit8List;
    Uint8List originalUnit8List;
    final http.Response response = await http.get(Uri.parse(imageUrl));
    originalUnit8List = response.bodyBytes;

    // final ui.Image originalUiImage = await decodeImageFromList(originalUnit8List);
    // final ByteData? originalByteData = await originalUiImage.toByteData();
    // print('original image ByteData size is ${originalByteData!.lengthInBytes}');

    final codec = await ui.instantiateImageCodec(originalUnit8List, targetHeight: 1280, targetWidth: 1280);
    final frameInfo = await codec.getNextFrame();
    final ui.Image targetUiImage = frameInfo.image;

    final ByteData? targetByteData = await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
    print('target image ByteData size is ${targetByteData!.lengthInBytes}');
    return targetlUinit8List = targetByteData.buffer.asUint8List();
  }

  ///
  /// Dinh dang ten file da upload
  ///
  static String getNameStatusOrder(String text) {
    if (text.isNotEmpty && text.toString() != 'null') {
      if (text == '0') {
        return 'Mới tạo';
      } else if (text == '1') {
        return 'Xác nhận';
      } else if (text == '2' || text == '3') {
        return 'Lấy hàng';
      } else if (text == '4' || text == '5') {
        return 'Đang giao';
      } else if (text == '6') {
        return 'Thành công';
      } else if (text == '7') {
        return 'Huỷ';
      }
    }
    return '';
  }

  /// blocks rotation; sets orientation to: portrait
  static void portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    print(DeviceOrientation.values);
  }

  List<BoxShadow> boxShadow = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(0, -2),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(2, 0),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(-2, 0),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
  ];
}
