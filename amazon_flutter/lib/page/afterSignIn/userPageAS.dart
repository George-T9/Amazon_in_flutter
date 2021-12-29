import 'package:amazon_flutter/model/product_model.dart';
import 'package:amazon_flutter/page/master.dart';
import 'package:amazon_flutter/util/applicationState.dart';
import 'package:amazon_flutter/widget/listItemWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UserPageAS extends StatelessWidget {
  const UserPageAS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _applicationState = Provider.of<ApplicationState>(context);
    User? _user = _applicationState.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amazon.in"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomDelegate());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(children: [
                Text(
                  "Hello, ${_user?.displayName}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1,
                ),
                const Spacer(),
                const CircleAvatar(
                  child: Icon(Icons.person),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Your Orders")),
                      )),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Buy Again")),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Your Account")),
                      )),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Buy Wish List")),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Your Order",
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
              child: Text("Hi! you have no recent orders"),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () {
                    var provider = Provider.of<BottomNavigationProvider>(
                        context,
                        listen: false);
                    provider.currentIndex = 0;
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text("Return to Homepage"),
                  )),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Keep shopping for"),
                        const Spacer(),
                        TextButton(onPressed: () {}, child: const Text("Edit")),
                        Container(
                          width: 1,
                          height: 18,
                          color: Colors.black,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Browsing history")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (BuildContext context, appState, Widget? child) {
        List<Product> searchedList = [];
        for (var item in ProductModel.products) {
          if (item.title.toLowerCase().contains(query.toLowerCase())) {
            searchedList.add(item);
          }
        }
        if (query.length > 3) {
          if (searchedList.isNotEmpty) {
            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Results",
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1,
                ),
              ),
              ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchedList.length,
                  itemBuilder: (context, index) {
                    Product product = searchedList[index];
                    return ProductListItem(product: product);
                  }),
            ]);
          }
        }
        return SizedBox.expand(
            child: Container(
              color: Colors.white,
              child:
              Center(child: SizedBox(
                width: 300,
                child: Image.asset(
                  "assets/images/undraw_the_search.png", fit:BoxFit.fitHeight,),
              )),
            ));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (BuildContext context, appState, Widget? child) {
        List<Product> searchedList = [];
        for (var item in ProductModel.products) {
          if (item.title.toLowerCase().contains(query.toLowerCase())) {
            searchedList.add(item);
          }
        }
        return ListView.builder(
            itemCount: searchedList.length,
            itemBuilder: (context, index) {
              Product product = searchedList[index];
              return ListTile(
                onTap: () {},
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(children: [
                        Text(
                          product.title,
                          maxLines: 1,
                        )
                      ]),
                      const Divider(),
                    ]),
              );
            });
      },
    );
  }
}
