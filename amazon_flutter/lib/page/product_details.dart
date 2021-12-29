import 'package:amazon_flutter/page/searchPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          InkWell(
              onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => const SearchPage(),
                    transitionsBuilder: (c, anim, c2, child) => FadeTransition(
                      opacity: anim,
                      child: child,
                    ),
                    transitionDuration: const Duration(milliseconds: 00),
                  )),
              child: const SearchBar(
                isVisible: false,
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Apple iPhone XR (64GB) - White",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  const CaroSlider(),
                  const SizedBox(
                    height: 8,
                  ),
                  const ExpansionColourAndType(),
                  const SizedBox(
                    height: 8,
                  ),
                  const PriceBox(),
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

class Item {
  Item(
      {required this.expandedValue,
      required this.headerValue,
      this.isExpanded = false});

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class ExpansionColourAndType extends StatefulWidget {
  const ExpansionColourAndType({Key? key}) : super(key: key);

  @override
  _ExpansionColourAndTypeState createState() => _ExpansionColourAndTypeState();
}

class _ExpansionColourAndTypeState extends State<ExpansionColourAndType> {
  List<Item> item = [
    Item(expandedValue: "expandedValue", headerValue: "headerValue"),
    Item(expandedValue: "expandedValue", headerValue: "headerValue")
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
            child: Row(
              children: [
                Container(
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
                    )),
              ],
            ),
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
                  Text("Style :"),
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

class CaroSlider extends StatefulWidget {
  const CaroSlider({Key? key}) : super(key: key);

  @override
  _CaroSliderState createState() => _CaroSliderState();
}

class _CaroSliderState extends State<CaroSlider> {
  int _curPosition = 0;

  final List<String> _imageUrlList = [
    "https://m.media-amazon.com/images/I/51PuFBgBK4L._SL1024_.jpg",
    "https://m.media-amazon.com/images/I/51gdkUuU26L._SL1024_.jpg",
    "https://m.media-amazon.com/images/I/41svnYkwUwL._SL1024_.jpg",
    "https://m.media-amazon.com/images/I/41UGBBFxXtL._SL1024_.jpg",
    "https://m.media-amazon.com/images/I/51W40Z3SaXL._SL1024_.jpg",
  ];

  @override
  Widget build(BuildContext context) {
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
              return GetImage(url: _imageUrlList[index]);
            },
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 500,
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
  const PriceBox({Key? key}) : super(key: key);

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
           Text("Total : 30000",style: Theme.of(context).textTheme.headline6,),
          const Divider(),
          Text("Free Delivery : Wednesday, Jan 5",style: Theme.of(context).textTheme.subtitle1,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: const Text("In Stock",style: TextStyle(color: Colors.deepPurple),),
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Buy Now"),
              )),
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
