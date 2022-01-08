import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String pid;
  final num deliveryTime;
  final num rating;
  final num price;
  final String title;
  final num discount;
  final bool freeDelivery;
  final QuerySnapshot? colors;
  final QuerySnapshot? style;
  final List<dynamic> imageUrl;

  Products(
      {required this.pid,
        required this.title,
        required this.price,
        this.rating = 4,
        this.deliveryTime = 5,
        required this.discount,
        this.freeDelivery = true,
        this.colors,
        this.style,
        required this.imageUrl});

  factory Products.fromMap(String pid,Map<String, dynamic> data) {
    return Products(
      pid: pid,
      title: data["title"],
      price: data["price"],
      rating: data["rating"],
      deliveryTime: data["deliveryTime"],
      discount: data["discount"],
      freeDelivery: data["freeDelivery"],
      colors: data["colors"],
      style: data["style_name"],
      imageUrl: data["imageUrls"],
    );
  }
}
