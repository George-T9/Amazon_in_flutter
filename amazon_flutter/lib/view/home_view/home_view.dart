import 'package:amazon_flutter/components/product_listrow.dart';
import 'package:amazon_flutter/components/search_bar.dart';
import 'package:amazon_flutter/view/search/searchView.dart';
import 'package:amazon_flutter/viewmodel/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:amazon_flutter/services/navigation_service.dart' as route;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("created 1}");
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          InkWell(
              onTap: () =>
                  Navigator.push(context, route.controller(route.searchRoute)),
              child: const SearchBar(
                isVisible: false,
                backButton: false,
              )),
          const SizedBox(
            height: 3,
          ),
          const Expanded(child: ProductList()),
        ],
      )),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ScrollController _scrollController = ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible) {
          setState(() {
            isVisible = true;
          });
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible) {
          setState(() {
            isVisible = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Consumer<ProductViewModel>(
          builder: (BuildContext context, productViewModel, Widget? child) {
            return productViewModel.productList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: productViewModel.productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var product = productViewModel.productList[index];
                      return ProductListRow(product: product);
                    },
                  );
          },
        ))
      ],
    );
  }
}
