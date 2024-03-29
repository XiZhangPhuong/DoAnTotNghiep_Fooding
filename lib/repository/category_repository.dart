// ignore_for_file: avoid_print, unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fooding_project/model/category/category.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';

class CategoryRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  CollectionReference collectionCategrys =
      FirebaseFirestore.instance.collection("categorys");
  CollectionReference collectionProduct =
      FirebaseFirestore.instance.collection("products");
  DatabaseReference databaseCategory =
      FirebaseDatabase.instance.ref().child('categorys');
  CollectionReference collectionStore =
      FirebaseFirestore.instance.collection("users");

  List<String> listImageSlider = [
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'
  ];

  

  ///
  /// get list category
  ///
  Future<List<Category>> getListCategory() async {
    List<Category> categorys = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categorys').get();
    for (var doc in querySnapshot.docs) {
      Category category = Category.fromMap(doc.data() as Map<String, dynamic>);
      categorys.add(category);
    }
    return categorys;
  }

  ///
  /// get all categorys
  ///
  Future<void> all({
    required Function(List<Category> data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categorys').where('isDeleted',isEqualTo: false).get();
      onSucess(querySnapshot.docs
          .map((e) => Category.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get name category
  ///
  Future<void> getNameCategory({
    required Function(List<String> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
     try{
       final ref = await FirebaseFirestore.instance.collection('categorys')
       .where('isDeleted',isEqualTo: false)
       .get();
       List<String> categoryNameList = ref.docs
        .map((doc) => doc.data()['name'] as String)
        .toList();

    onSuccess(categoryNameList);
     }catch(e){
       onError(e);
     }
  }
}
