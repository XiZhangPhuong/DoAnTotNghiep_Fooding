import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/product/products.dart';

class ProductsRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  CollectionReference collectionProduct =
      FirebaseFirestore.instance.collection("products");
  CollectionReference collectionStore =
      FirebaseFirestore.instance.collection("users");

  ///
  /// delete product
  ///

  Future<void> deleteCartDocumentAndSubcollections(String idUser) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(idUser);
    await cartRef.collection('listProduct').get().then((listProductSnap) {
      for (var listProductDoc in listProductSnap.docs) {
        listProductDoc.reference.delete();
      }
    });
    await cartRef.delete();
  }

  ///
  /// add list cart
  ///
  Future<void> pushDataProduct(List<Products> listProducts) async {
    for (var i in listProducts) {
      await collectionProduct.doc(i.id!).set(i.toMap());
    }
  }

  // Xóa document trong collection "Cart" theo "idUser"
  Future<void> deleteCartByUserId(String idUser) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(idUser);
    await cartRef.delete();
  }

  ///
  /// get data products filter name category
  ///
  Future<List<Products>> getProductList(String nameCategpry) async {
    List<Products> listProducts = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('nameCategory', isEqualTo: nameCategpry)
        .get();
    for (var element in querySnapshot.docs) {
      Products products =
          Products.fromMap(element.data() as Map<String, dynamic>);
      listProducts.add(products);
    }
    return listProducts;
  }

  ///
  /// get all list product
  ///
  Future<void> getAllListProduct({
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      onSucess(querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get list product paginate page = 1 , limit = 10
  ///
  Future<void> paginateProducts({
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .limit(limit)
          .get();
      onSucess(querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get list product paginate page = 1 , limit = 10 by id Category
  ///
  Future<void> paginateProductsByIDCateogry({
    required String idCategory,
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('nameCategory', isEqualTo: idCategory)
          .limit(limit)
          .get();
      onSucess(querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get list product paginate limit = 10  by name product
  ///
  Future<void> paginateProductsByNameProduct({
    required String value,
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: value)
          .get();
      onSucess(querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// paginate list product limit = 10 , filter by id, sort by price . 
  ///
Future<void> paginateAllProductFilter({
    String? idProduct,
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('idProduct', isEqualTo: idProduct)
          .orderBy('price',descending: true)
          .limit(limit)
          .get();
      onSucess(querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }


  ///
  /// count list product filter id Store
  ///

  Future<void> countProductByIdStore({
    required String idStore,
    required Function(int data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('idUser', isEqualTo: idStore)
          .get();
       onSucess(querySnapshot.docs.length);   
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// find product by id
  ///
  Future<void> find({
    required String idProduct,
    required Function(Products data) onSucess,
    required Function(dynamic error) onError,
  }) async {
     try{
      final query = await FirebaseFirestore.instance
      .collection('products').doc(idProduct).get();
      onSucess(Products.fromMap(query.data() as Map<String,dynamic>));
     }catch(e){
      onError(e);
     }
  }

  ///
  /// post data product to firebase store
  ///
  Future<void> post(
      {required Function(Products data) onSucess,
      required Function(dynamic error) onError}) async {
    try {} catch (e) {
      onError(e);
    }
  }
}
