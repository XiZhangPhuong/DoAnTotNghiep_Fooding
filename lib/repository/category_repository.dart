// ignore_for_file: avoid_print, unused_field

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fooding_project/model/category/category.dart';

class CategoryRepository{
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    CollectionReference collection  = FirebaseFirestore.instance.collection("categorys");
    DatabaseReference  databaseCategory = FirebaseDatabase.instance.ref().child('categorys');
   ///
   /// Push list Category to FireStore
   ///
   Future<void> pushListCategory() async{
      try{ 
        List<Category> listCate = [
          Category(id: generateRandomString(),thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1565-1590397916?w=240&amp;type=s",name: "Cơm"),
          Category(id: generateRandomString(),thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1533-1590653836?w=240&amp;type=s",name: "Bún|Mì"),
          Category(id: generateRandomString(),thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-21-1590397610?w=240&amp;type=s",name: "Đồ uống"),
          Category(id: generateRandomString(),thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1164-1590572746?w=240&amp;type=s",name: "Hải sản"),
          Category(id: generateRandomString(),thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1407-1590396880?w=240&amp;type=s",name: "Đồ ăn nhanh"),
          Category(id: generateRandomString(),thumnail: "https://st.depositphotos.com/1332722/1245/v/950/depositphotos_12454057-stock-illustration-pizza-vector-illustration.jpg",name: "Ăn vặt"),
          Category(id: generateRandomString(),thumnail: "https://img.pikbest.com/png-images/qianku/eating-hot-pot-at-home_2400223.png!bw340",name: "Nướng|Lẩu"),
          Category(id: generateRandomString(),thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-77-1617002219?w=240&amp;type=s",name: "Món nhậu"),                  
        ];
        //pust Data to FireStore
        //  for (var element in listCate) {
        //    await  collection.doc(element.id).set(element.toMap());
        // }

        // push data to realtime
        for(var element in listCate){
          await databaseCategory.child(element.id!).set(element.toMap());
        }
      }catch(e){
         print("Add List Category Failt  $e");
      }
   }



///
/// random ID category
///
String generateRandomString() {
  var random = Random();
  var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(
    List.generate(20, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}
}