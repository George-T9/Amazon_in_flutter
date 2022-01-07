import 'package:amazon_flutter/model/product_model.dart';
import 'package:amazon_flutter/page/loginPages/main_login_page.dart';
import 'package:amazon_flutter/page/searchPage.dart';
import 'package:amazon_flutter/util/applicationState.dart';
import 'package:amazon_flutter/widget/extraWidget.dart';
import 'package:amazon_flutter/widget/listItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                isVisible: false,backButton: false,
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
        // const DeliveryTab(),
        FilterTab(
          isVisible: isVisible,
        ),
        Expanded(
          child: Consumer<ApplicationState>(
            builder: (BuildContext context, appState, _) {
              appState.getProduct((e) {
                showErrorDialog(context, e);
              });
              if (ProductModel.products.isNotEmpty) {
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: ProductModel.products.length,
                    itemBuilder: (context, index) {
                      final product = ProductModel.products[index];
                      return ProductListItem(
                        product: product,
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
