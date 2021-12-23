import 'package:amazon_flutter/model/product_model.dart';
import 'package:amazon_flutter/page/loginPages/main_login_page.dart';
import 'package:amazon_flutter/util/applicationState.dart';
import 'package:amazon_flutter/widget/extraWidget.dart';
import 'package:amazon_flutter/widget/listItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: const [
        SearchBar(),
        SizedBox(height: 1,),
        DeliveryTab(),
        Expanded(child: ProductList()),
      ],
    ));
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
        FilterTab(isVisible: isVisible,),
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
