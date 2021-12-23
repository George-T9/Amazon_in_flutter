
import 'package:amazon_flutter/widget/extraWidget.dart';
import 'package:amazon_flutter/widget/listItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchBar(),
        Text(
          'Result',
          style: Theme.of(context).textTheme.headline6,
        ),
        // Expanded(
        //   child: ListView.builder(
        //       itemCount: 30,
        //       itemBuilder: (context, index) {
        //         return InkWell(
        //           onTap: () {},
        //           child: const ProductListItem(product:,),
        //         );
        //       }),
        // ),
      ],
    );
  }
}


