import 'package:amazon_flutter/components/search_bar.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:amazon_flutter/viewmodel/product_notifier.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:amazon_flutter/services/navigation_service.dart' as route;

var product = '';
class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Products;
    final productVm = Provider.of<ProductViewModel>(context);
    // productVm.getProductById(args.pid);
    // Product? product = productVm.currentProduct;
    return Scaffold(
      body: SafeArea(
          child: product == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    InkWell(
                        onTap: () => Navigator.push(
                            context, route.controller(route.searchRoute)),
                        child: const SearchBar(
                          isVisible: false,
                          backButton: true,
                        )),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            HeadingText(product: product,),
                            CaroSlider(
                              product: product,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const ExpansionColourAndType(),
                            const SizedBox(
                              height: 8,
                            ),
                            PriceBox(product: product),
                            const SizedBox(
                              height: 8,
                            ),
                            const UserOption(),
                            Column(
                              children: [
                                const Text("Details"),
                                Row(
                                  children: const [
                                    Expanded(child: Text("Details")),
                                    Expanded(child: Text("Details")),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}

class HeadingText extends StatelessWidget {
  final Products product;
  const HeadingText({Key? key,required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 14),
      child: Text(
        product.title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class CaroSlider extends StatefulWidget {
  final Products product;

  const CaroSlider({Key? key, required this.product}) : super(key: key);

  @override
  _CaroSliderState createState() => _CaroSliderState();
}

class _CaroSliderState extends State<CaroSlider> {
  int _curPosition = 0;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> _imageUrlList = widget.product.imageUrl;
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(offset: Offset(0, 1), color: Colors.black26, blurRadius: 4)
      ]),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: _imageUrlList.length,
            itemBuilder: (context, index, count) {
              var url = _imageUrlList[index];
              return index == 0
                  ? Hero(
                  tag: Key(widget.product.pid.toString()),
                  child: Image.network(url))
                  : Image.network(url);
            },
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 500,
              enableInfiniteScroll: false,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  _curPosition = index;
                });
              },
              viewportFraction: 0.8,
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _imageUrlList.map((url) {
                  int index = _imageUrlList.indexOf(url);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _curPosition
                            ? Colors.deepPurple
                            : Colors.black26),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}

class Item {
  Item(
      {
      this.isExpanded = false});

  bool isExpanded;
}

class ExpansionColourAndType extends StatefulWidget {
  const ExpansionColourAndType({Key? key}) : super(key: key);

  @override
  _ExpansionColourAndTypeState createState() => _ExpansionColourAndTypeState();
}

class _ExpansionColourAndTypeState extends State<ExpansionColourAndType> {
  List<Item> item = [
    Item(),
    Item()
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          item[index].isExpanded = !isExpanded;
        });
      },
      children: <ExpansionPanel>[
        ExpansionPanel(
          isExpanded: item[0].isExpanded,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) => Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Row(
              children: const [Text("Color :"), Text("Blazing Black")],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: ColorList(),
          ),
        ),
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: item[1].isExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Row(
                children: const [
                  Text("Style : "),
                  Text("6GB Ram, 128GB Storage")
                ],
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple)),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          "6GB Ram, 128GB Storage",
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration:
                            const BoxDecoration(color: Colors.deepPurple),
                        padding: const EdgeInsets.all(12),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("Price"),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text("In stock"),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 12),
                        child: Text("free delivery"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorList extends StatelessWidget {
  const ColorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 5,itemBuilder: (context,index){
      return Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  "https://m.media-amazon.com/images/I/71q297sVv3L._AC_UL320_.jpg",
                  width: 100,
                ),
              ),
              Container(
                decoration:
                const BoxDecoration(color: Colors.deepPurple),
                width: 124,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Blazing Black",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ));
    });
  }
}


class GetImage extends StatelessWidget {
  const GetImage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.contain,
    );
  }
}

class PriceBox extends StatelessWidget {
  const PriceBox({Key? key, required this.product}) : super(key: key);

  final Products? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(offset: Offset(0, 1), color: Colors.black26, blurRadius: 4)
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "M.R.P  : ",
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.end,
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Text(
                    "  ${product?.price}",
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "Deal Price  :  ",
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.end,
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Text(
                    "  63000",
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "You Save  :",
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.end,
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Text(
                    "  63000",
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Spacer(),
              SizedBox(
                width: 9,
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child:
                    Text("EMI from \$1,506. No Cost EMI available EMI options"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Spacer(),
              SizedBox(
                width: 9,
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Text("Inclusive of all taxes"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class UserOption extends StatelessWidget {
  const UserOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 4, offset: Offset(0, 1), color: Colors.black26),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Total : 30000",
            style: Theme.of(context).textTheme.headline6,
          ),
          const Divider(),
          Text(
            "Free Delivery : Wednesday, Jan 5",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              "In Stock",
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Buy Now"),
              )),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Add to Cart"),
              )),
          TextButton(
              onPressed: () {},
              child: Row(
                children: const [Icon(Icons.lock), Text(" Secure transaction")],
              )),
          TextButton(onPressed: () {}, child: const Text("ADD TO WISH LIST"))
        ],
      ),
    );
  }
}
