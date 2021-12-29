import 'package:amazon_flutter/model/product_model.dart';
import 'package:amazon_flutter/widget/extraWidget.dart';
import 'package:amazon_flutter/widget/listItemWidget.dart';
import 'package:amazon_flutter/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SearchBar(),
            SizedBox(
              height: 10,
            ),
            Expanded(child: SearchResult())
          ],
        ),
      ),
    );
  }
}

class SearchSuggestion extends StatelessWidget {
  const SearchSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Text(
            "Filter By Category",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text("Mobiles & Accessories"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text("Audio Headphones"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text("Laptops"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text("Tablets"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text("Computer Accessories & Peripherals"),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Text(
            "RESULTS",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: provider.searchList.length,
              itemBuilder: (context, index) {
                final product = provider.searchList[index];
                return ProductListItem(product: product);
              })
        ],
      ),
    );
  }
}

class SearchProvider with ChangeNotifier {
  final List<Product> _searchList = [];

  List<Product> get searchList => _searchList;

  void add(Product product) {
    _searchList.add(product);
  }

  void search(String query) {
    _searchList.clear();
    if (query.isNotEmpty) {
      for (var product in ProductModel.products) {
        if (product.title.toLowerCase().contains(query.toLowerCase())) {
          add(product);
          notifyListeners();
        }
      }
    } else {
      _searchList.clear();
      notifyListeners();
    }
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, this.isVisible = true}) : super(key: key);
  final bool isVisible;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.lightTheme(context).backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: 10, bottom: 8, left: widget.isVisible ? 0 : 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.isVisible,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.white,)),
            ),
            Expanded(
              child: TextFormField(
                enabled: widget.isVisible,
                maxLines: 1,
                onFieldSubmitted: (query) {
                  Provider.of<SearchProvider>(context, listen: false)
                      .search(query);
                },
                onChanged: (query) {
                  setState(() {
                  });
                },
                // Provider.of<SearchProvider>(context, listen: false)
                //     .search(query),
                autofocus: true,
                controller: searchTextField,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search,),
                    suffixIcon: widget.isVisible
                        ? searchTextField.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchTextField.clear();
                                  setState(() {

                                  });
                                },
                              )
                        : IconButton(
                            icon: const Icon(Icons.camera,),
                            onPressed: () {
                              searchTextField.clear();
                            },
                          ),
                    hintText: "Search Amazon.in"),
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.mic,color: Colors.white,))
          ],
        ),
      ),
    );
  }
}
