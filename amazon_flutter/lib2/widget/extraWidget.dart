import 'package:amazon_flutter/page/afterSignIn/userPageAS.dart';
import 'package:amazon_flutter/page/searchPage.dart';
import 'package:amazon_flutter/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class DeliveryTab extends StatelessWidget {
  const DeliveryTab({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.lightTheme(context).secondaryHeaderColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            Icon(Icons.location_on),
            Text("Deliver to George"),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }
}

class FilterTab extends StatefulWidget {
  bool isVisible = true;

  FilterTab({Key? key, required this.isVisible}) : super(key: key);

  @override
  _FilterTabState createState() => _FilterTabState();
}

class _FilterTabState extends State<FilterTab> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        color: MyTheme.lightTheme(context).secondaryHeaderColor,
        duration: const Duration(milliseconds: 200),
        height: widget.isVisible ? 40 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              // const Text("Prime"),
              // Switch(
              //     value: _switchValue,
              //     onChanged: (value) {
              //       setState(() {
              //         _switchValue = value;
              //       });
              //     }),
              const Spacer(),
              Container(
                width: 1,
                color: Colors.black,
                height: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Text("Filter"),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}