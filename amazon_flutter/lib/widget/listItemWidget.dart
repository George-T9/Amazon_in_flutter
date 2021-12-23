import 'package:amazon_flutter/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
          child: Row(
            children: [
              SizedBox(width:80,child: Image.network(product.imageUrl.first)),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBarIndicator(
                      rating: product.rating.toDouble(),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 16.0,
                    ),
                    Text(product.price.toString()),
                    const Divider(),
                    Text(
                      "Get it by Friday, December 2${product.deliveryTime}, FREE Delivery by Amazon",
                      maxLines: 2,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
