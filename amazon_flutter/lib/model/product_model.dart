class ProductModel {
  static List<Product> products = [];

  Product getById(String pid) => products.firstWhere((element) => element.pid == pid, orElse: null);
}

class Product {
  Product(
      {required this.pid,
      required this.title,
      required this.price,
      required this.rating,
      required this.deliveryTime,
      required this.discount,
      required this.freeDelivery,
      required this.imageUrl});

  final String pid;
  final num deliveryTime;
  final num rating;
  final String price;
  final String title;
  final num discount;
  final bool freeDelivery;
  final List<dynamic> imageUrl;
}
