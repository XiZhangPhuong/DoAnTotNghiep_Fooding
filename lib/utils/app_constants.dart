// ignore_for_file: unnecessary_null_comparison, constant_identifier_names
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String BASE_URL = 'https://p31giaibaitap.izisoft.io/v1/';
const String BASE_TEST = 'https://jsonplaceholder.typicode.com/';
const String BASE_URL_IMAGE = 'https://p31giaibaitap.izisoft.io/v1/  ';
const String SOCKET_URL = 'wss://socket1.crudcode.tk';

const String notificationChannelId = 'dpfood_customer_channel';
const String FCM_TOPIC_DEFAULT = 'fcm_all';
const String NOTIFICATION_KEY = 'notification_key';
const String NOTIFICATION_TITLE = 'title';
const String NOTIFICATION_BODY = 'body';

///
/// random ID category
///
String generateRandomString(int length) {
  var random = Random();
  var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(
    List.generate(
        length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}

// font
const String NUNITO = 'Nunito';

///
/// Muốn set ngôn ngữ tự động theo ngôn ngữ máy
///
Locale localeResolutionCallback(
    Locale locale, Iterable<Locale> supportedLocales) {
  if (locale == null) {
    return supportedLocales.first;
  }
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return supportedLocale;
    }
  }
  return supportedLocales.first;
}

List<LocalizationsDelegate> localizationsDelegates = [
  // AppLocalizations.delegate,// Load dư liệu trước
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate
];

const String DA_XEM = 'DA_XEM';
const String HUY_BO = 'HUY_BO';

const htmlData = """
<p id='top'><a href='#bottom'>Scroll to bottom</a></p>
      <h1>Header 1</h1>
      <h2>Header 2</h2>
      <h3>Header 3</h3>
      <h4>Header 4</h4>
      <h5>Header 5</h5>
      <h6>Header 6</h6>
      <h3>Ruby Support:</h3>
     
""";
const HOI_CHI_TIET = 'HOI_CHI_TIET';
const THEO_DOI = 'THEO_DOI';
const BAO_VI_PHAM = 'BAO_VI_PHAM';

/// Status question. ( ANSWERED | UNANSWERED | FIRST_TIME_ASKING )
const String ANSWERED = 'ANSWERED';
const String UNANSWERED = 'UNANSWERED';
const String FIRST_TIME_ASKING = 'FIRST_TIME_ASKING';

/// Socket IO.
const String ANSWER = 'p31giaibaitap_answer';
const String ANSWER_TYPING = 'p31giaibaitap_answerer-typing';
const String COMMENT = 'p31giaibaitap_comment';
const String COMMENT_TYPING = 'p31giaibaitap_comment-typing';
const String NOTIFICATION = 'p31giaibaitap_notification';
const String COMMENT_ANSWER = 'p31giaibaitap_comment-answer';
const String COMMENT_ANSWER_TYPING = 'p31giaibaitap_comment-answer-typing';

/// Type token login.
const String GOOGLE = 'GOOGLE';
const String FACEBOOK = 'FACEBOOK';

const String SUCCESS = 'SUCCESS';

const String CUSTOMER = 'CUSTOMER';
const String CASH = "CASH";
const String BANKING = "BANKING";

Future<void> LOGOUT() async {
  await FirebaseAuth.instance.signOut();
}

const String PENDING = "PENDING",
    DELIVERING = "DELIVERING",
    DONE = "DONE",
    CANCEL = "CANCEL";

const APIGG = "AIzaSyB5o0AVp5OB0El-Vo3Vu5w5TeaAqc8SYUw";

const SERVERKEY =
    'AAAAJHKDYUk:APA91bFG3OFHMbiGsgLbJQEnl73YO22SgX4YPdRsFhA4wuWP_sjDWD9tt4rVwYUPPm9PD-9RHOSOdCxKgmmgTvhIu9mgN6R2MzMmTiAyMeeQsyfKPGeWwus0zt-kLSHSESqZcqYusDzY';
