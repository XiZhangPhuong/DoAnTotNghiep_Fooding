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
    List<Products> listProducts  =  [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products')
        .where('nameCategory',isEqualTo: nameCategpry)
        .get();
    for (var element in querySnapshot.docs) {
      Products products =
          Products.fromMap(element.data() as Map<String, dynamic>);
      listProducts.add(products);
    }
    return listProducts;
  }
}
