import 'package:amazon_flutter/components/product_listrow.dart';
import 'package:amazon_flutter/components/search_bar.dart';
import 'package:amazon_flutter/viewmodel/product_notifier.dart';
import 'package:flutter/material.dart';
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
    final provider = Provider.of<ProductViewModel>(context);

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
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: const ScrollPhysics(),
          //     itemCount: provider.searchList.length,
          //     itemBuilder: (context, index) {
          //       final product = provider.searchList[index];
          //       return ProductListRow(product: product);
          //     })
        ],
      ),
    );
  }
}