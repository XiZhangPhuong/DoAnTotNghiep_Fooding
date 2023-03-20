// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';

// import '../base_widget/izi_image.dart';
// import '../utils/color_resources.dart';
// import '../utils/images_path.dart';
// import 'izi_device.dart';
// import 'izi_dimensions.dart';
// import 'izi_size.dart';


// ///
// /// Enum type of alert.
// ///
// enum TypeOfAlert {
//   ERROR,
//   SUCCESS,
//   INFO,
// }

// class IZIAlert {
//   ///
//   /// Declare toast.
//   final showToast = FToast();

//   IZIAlert() {
//     init();
//   }

//   ///
//   /// Init toast.
//   ///
//   void init() {
//     showToast.init(Get.context!);
//   }

//   ///
//   /// Show info.
//   ///
//   void info({
//     required String message,
//     ToastGravity? toastGravityPosition,
//   }) {
//     showToast.removeQueuedCustomToasts();
//     showToast.showToast(
//       positionedToastBuilder: (context, child) {
//         return Positioned(
//           top: IZIDimensions.iziSize.height * .056,
//           left: 0,
//           right: 0,
//           child: child,
//         );
//       },
//       toastDuration: const Duration(seconds: 3),
//       child: customToast(message: message, typeOfAlert: TypeOfAlert.INFO),
//       gravity: toastGravityPosition ?? ToastGravity.TOP,
//     );
//   }

//   ///
//   /// Show successfully.
//   ///
//   void success({
//     required String message,
//     ToastGravity? toastGravityPosition,
//   }) {
//     showToast.removeQueuedCustomToasts();
//     showToast.showToast(
//       positionedToastBuilder: (context, child) {
//         return Positioned(
//           top: IZIDimensions.iziSize.height * .056,
//           left: 0,
//           right: 0,
//           child: child,
//         );
//       },
//       child: customToast(message: message, typeOfAlert: TypeOfAlert.SUCCESS),
//       gravity: toastGravityPosition ?? ToastGravity.TOP,
//     );
//   }

//   ///
//   /// Show error.
//   ///
//   void error({
//     required String message,
//     ToastGravity? toastGravityPosition,
//   }) {
//     showToast.removeQueuedCustomToasts();
//     showToast.showToast(
//       positionedToastBuilder: (context, child) {
//         return Positioned(
//           top: IZIDimensions.iziSize.height * .056,
//           left: 0,
//           right: 0,
//           child: child,
//         );
//       },
//       child: customToast(message: message, typeOfAlert: TypeOfAlert.ERROR),
//       gravity: toastGravityPosition ?? ToastGravity.TOP,
//     );
//   }

//   ///
//   /// customToastSuccessful
//   ///
//   Widget customToast({
//     required String message,
//     required TypeOfAlert typeOfAlert,
//     Color? colorBG,
//     double? sizeWidthToast,
//   }) {
//     ///
//     /// Generate title alert.
//     ///
//     String _genTitleAlert(TypeOfAlert type) {
//       switch (type) {
//         case TypeOfAlert.SUCCESS:
//           return 'Well done!';
//         case TypeOfAlert.INFO:
//           return 'Hi there!';
//         default:
//           return 'Warring!';
//       }
//     }

//     ///
//     /// Generate background color.
//     ///
//     Color _genBackgroundColor(TypeOfAlert type) {
//       switch (type) {
//         case TypeOfAlert.SUCCESS:
//           return ColorResources.GREEN;
//         case TypeOfAlert.INFO:
//           return Colors.blue;
//         default:
//           return ColorResources.RED;
//       }
//     }

//     ///
//     /// Convert color to dark color.
//     ///
//     HSLColor _genDartColor(TypeOfAlert type) {
//       switch (type) {
//         case TypeOfAlert.SUCCESS:
//           final hsl = HSLColor.fromColor(ColorResources.GREEN);
//           final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 0.9));
//           return hslDark;
//         case TypeOfAlert.INFO:
//           final hsl = HSLColor.fromColor(Colors.blue);
//           final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 0.9));
//           return hslDark;
//         default:
//           final hsl = HSLColor.fromColor(ColorResources.RED);
//           final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 0.9));
//           return hslDark;
//       }
//     }

//     ///
//     /// Generate image path.
//     ///
//     String _genImagePath(TypeOfAlert type) {
//       switch (type) {
//         case TypeOfAlert.SUCCESS:
//           return ImagesPath.successAlert;
//         case TypeOfAlert.INFO:
//           return ImagesPath.helpAlert;
//         default:
//           return ImagesPath.warningAlert;
//       }
//     }

//     return Row(
//       children: [
//         Expanded(
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: IZIDimensions.iziSize.width * .03,
//                 ),
//                 padding: EdgeInsets.fromLTRB(
//                   IZIDimensions.iziSize.width * .15,
//                   IZIDimensions.SPACE_SIZE_3X,
//                   IZIDimensions.SPACE_SIZE_2X,
//                   IZIDimensions.SPACE_SIZE_3X,
//                 ),
//                 decoration: BoxDecoration(
//                   color: _genBackgroundColor(typeOfAlert),
//                   borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 25,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _genTitleAlert(typeOfAlert),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: IZIDimensions.FONT_SIZE_H6,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: IZIDimensions.ONE_UNIT_SIZE * 2),
//                             child: Text(
//                               message,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: IZIDimensions.FONT_SIZE_SPAN,
//                               ),
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               /// other SVGs in body
//               Positioned(
//                 bottom: 0,
//                 left: IZIDimensions.iziSize.width * .03,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(IZIDimensions.BORDER_RADIUS_4X),
//                   ),
//                   child: IZIImage(
//                  ImagesPath.bubblesAlert,
//                     height: IZIDimensions.iziSize.height * 0.05,
//                     width: IZIDimensions.iziSize.width * 0.04,
//                     colorIconsSvg: _genDartColor(typeOfAlert).toColor(),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 top: -IZIDimensions.iziSize.height * 0.018,
//                 left: IZIDimensions.iziSize.width * .1,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     IZIImage(
//                       ImagesPath.backAlert,
//                       width: IZISize.device == IZIDevice.TABLE
//                           ? IZIDimensions.iziSize.width * 0.04
//                           : IZIDimensions.iziSize.width * 0.08,
//                       colorIconsSvg: _genDartColor(typeOfAlert).toColor(),
//                     ),
//                     Positioned(
//                       top: IZIDimensions.iziSize.height * 0.008,
//                       child: IZIImage(
//                         _genImagePath(typeOfAlert),
//                         height: IZIDimensions.iziSize.height * 0.022,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
