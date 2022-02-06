import 'package:amazon_flutter/main.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:amazon_flutter/services/firebase_service.dart';

class ProductViewModel with ChangeNotifier {


  // late String _currentProductID;
  List<Products> _searchList = [];

  final _firebase = getIt<FirebaseService>();


  List<Products> get searchList => _searchList;


  Products getProductByTitle(String title) =>
      _productList
          .firstWhere((element) => element.title == title, orElse: null);


  ProductViewModel(){
    generateProductList();
  }

  List<Products> _productList = [];

  List<Products> get productList => _productList;

  void generateProductList() async {
    final snapshot = await _firebase.getAllProducts();
    if (snapshot is QuerySnapshot) {
      _productList = [];
      for (final document in snapshot.docs) {
        final style = await _firebase.getStyle(document.id) as QuerySnapshot;
        final colors = await _firebase.getColors(document.id) as QuerySnapshot;
        for (var _style in style.docs) {
          for (var _colors in colors.docs) {
            _productList.add(Products(
                pid: "${document.id}/${_style.id}/${_colors.id}",
                title: "${document["model_name"]} ( ${_colors["color"]} ${_style["style_name"]} )",
                price: _style["price"],
                discount: _style["discount_percentage"],
                imageUrl: _colors["images"]
            ));
          }
        }
      }
      notifyListeners();
    }
  }

  searchProductByTitle(String query) async {

  }
}
