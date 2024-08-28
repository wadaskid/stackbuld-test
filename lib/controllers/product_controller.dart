import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stackbuld/models/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    firestore.collection('products').snapshots().listen((snapshot) {
      products.value = snapshot.docs
          .map((doc) => Product.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addProduct(Product product) async {
    await firestore.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(String id, Product product) async {
    await firestore.collection('products').doc(id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await firestore.collection('products').doc(id).delete();
  }
}
