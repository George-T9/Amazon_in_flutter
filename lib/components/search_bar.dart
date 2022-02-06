
import 'package:amazon_flutter/util/theme.dart';
import 'package:amazon_flutter/viewmodel/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, this.isVisible = true,this.backButton=true}) : super(key: key);
  final bool isVisible,backButton;

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
            top: 10, bottom: 8, left: widget.isVisible? 0 : widget.backButton ? 0:10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.backButton,
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
                  Provider.of<ProductViewModel>(context, listen: false).searchProductByTitle(query);
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
