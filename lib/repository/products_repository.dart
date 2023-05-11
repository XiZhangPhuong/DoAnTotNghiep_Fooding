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
  /// get by name Product
  ///
  Future<void> paginateByNameProduct({
    required String nameProduct,
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('name', isEqualTo: nameProduct)
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
  /// get list product paginate page = 1 , limit = 10 by id Category and idStore
  ///
  Future<void> paginateProductsByIDCateogryandIdStore({
    required String idCategory,
    required String idUser,
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('nameCategory', isEqualTo: idCategory)
          .where('idUser', isEqualTo: idUser)
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
          .orderBy('price', descending: true)
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
    try {
      final query = await FirebaseFirestore.instance
          .collection('products')
          .doc(idProduct)
          .get();
      onSucess(Products.fromMap(query.data() as Map<String, dynamic>));
    } catch (e) {
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

  ///
  /// paginate recommmend list product
  ///
  Future<void> paginateRecommendProducts({
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('sold', descending: true)
          .where('sold', isGreaterThan: 0)
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
  /// paginate recommmend list product
  ///
  Future<void> paginateFlashsaleProducts({
    required int limit,
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('priceDiscount', isGreaterThan: 0)
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
  /// get name category in idStore
  ///
  Future<void> getNameCategoryByIDStore({
    required String idStore,
    required Function(List<dynamic> data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('idUser', isEqualTo: idStore)
          .where('isShow', isEqualTo: true)
          .get();
      final List<dynamic> nameCategoryList =
          querySnapshot.docs.map((doc) => doc['nameCategory']).toSet().toList();
      nameCategoryList.sort((a, b) => a.compareTo(b));

      onSucess(nameCategoryList);
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// paginate product by idStore
  ///
  Future<void> paginateProductByIDStore({
    required String idStore,
    required Function(List<Products> data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('idUser', isEqualTo: idStore)
          .where('isShow', isEqualTo: true)
          .get();
      onSucess(querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// count sold by idStore
  ///

  Future<void> countSoldProductByIdStore({
    required String idStore,
    required Function(int data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('idUser', isEqualTo: idStore)
          .get();

      int count = 0;
      List<Products> listProduct = querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      for (int i = 0; i < listProduct.length; i++) {
        count += listProduct[i].sold!;
      }
      onSucess(count);
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get name category
  ///
  Future<void> getNameProduct({
    required Function(List<String> data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      List<Products> listProducts = querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      final name = <String>[];
      for (int i = 0; i < listProducts.length; i++) {
        name.add(listProducts[i].name!);
      }
      name.toSet().toList();
      onSucess(name);
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// Update Product by idProduct
  ///
  Future<void> updateProduct({
    required String idProduct,
    required Products product,
    required Function() onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(idProduct)
          .update(product.toMap());
      onSucess();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get list product favorite
  ///
  Future<void> getListProductFavorite({
    required idUser,
    required Function(List<Products> data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('favorites', arrayContains: idUser)
          .get();
      onSucess(querySnapshot.docs
          .map((e) => Products.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// check id like product
  ///
  Future<void> checkUserLikeProduct({
    required idUser,
    required idProduct,
    required Function(bool data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('favorites', arrayContains: idUser)
          .where(FieldPath.documentId, isEqualTo: idProduct)
          .get();
      onSucess(querySnapshot.docs.isNotEmpty);
    } catch (e) {
      onError(e);
    }
  }
}
