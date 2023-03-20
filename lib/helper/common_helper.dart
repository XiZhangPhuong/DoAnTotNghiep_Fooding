import 'dart:io';

import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonHelper {
  ///
  ///  A Dart library for unescaping HTML-encoded strings.
  ///
  String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
    
  }

  // String convert

  static Future openLink({required String url})async{
    if(await canLaunch(url)){
      await launch(url);
    }
  }

  
  static Future callPhone({required String phone})async{
    // Check for phone call support
    if(await canLaunch(Platform.isIOS ? "tel://$phone" : "tel:$phone")){
      await launch(Platform.isIOS ? "tel://$phone" : "tel:$phone");
    }
  }

  ///
  /// genMoney
  ///
  // static String covertNumberToText({required String giaBan}) {
  //   final int countMoneyLength = giaBan.length;
  //   final double moneyFomat = IZINumber.parseDouble(giaBan.toString());
  //   final List<String> unitMoney = ["", "Nghìn", "Triệu", "Tỷ", "Ngàn tỷ"];
  //   int position = 0;
  //   double value = 0;
  //   // 100
  //   // 100.000
  //   // 100.000.000
  //   // 100.000.000.000
  //   // 100.000.000.000.000
  //   if (countMoneyLength <= 3) {
  //     return '${PriceConverter.convertPriceNoContext(moneyFomat)} VNĐ';
  //   } else if (countMoneyLength <= 6) {
  //     position = 1;
  //     value = moneyFomat / 1000;
  //     return '${value.toString().length <= 6 ? value : value.toStringAsFixed(4)} ${unitMoney[position]}';
  //   } else if (countMoneyLength <= 9) {
  //     position = 2;
  //     value = moneyFomat / 1000000;
  //     return '${value.toString().length <= 6 ? value : value.toStringAsFixed(4)} ${unitMoney[position]}';
  //   } else if (countMoneyLength <= 12) {
  //     position = 3;
  //     value = moneyFomat / 1000000000;
  //     return '${value.toString().length <= 6 ? value : value.toStringAsFixed(4)} ${unitMoney[position]}';
  //   } else if (countMoneyLength <= 15) {
  //     position = 4;
  //     value = moneyFomat / 1000000000000;
  //     return '${value.toString().length <= 6 ? value : value.toStringAsFixed(4)} ${unitMoney[position]}';
  //   }
  //   return "Không có";
  // }

    

}
