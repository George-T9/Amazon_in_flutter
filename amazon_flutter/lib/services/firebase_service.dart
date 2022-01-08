import 'package:amazon_flutter/util/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collection;

  FirebaseService() {
    init();
  }

  Future<dynamic> getAllProducts() async {
    try {
      var snapshot = await collection.get();
      return snapshot;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getColors(String id) async {
    try {
      final _snapshot = await collection.doc(id).collection("colors").get();
      return _snapshot;
    } catch (e) {}
  }

  Future<dynamic> getStyle(String id) async {
    try {
      return await collection.doc(id).collection("style_name").get();
    } catch (e) {}
  }

  Future<dynamic> searchProductByTitle(String query) async {
    try {
      return await collection
          .where("title", isGreaterThanOrEqualTo: query)
          .get();
    } on FirebaseException catch (e) {
      return e;
    }
  }

  Future<dynamic> getProductById(String pid) async {
    try {
      return await collection.doc(pid).get();
    } on FirebaseException catch (e) {
      return e;
    }
  }

  void init() {
    collection = _firebaseFirestore.collection(firebaseCollection);
  }
}
