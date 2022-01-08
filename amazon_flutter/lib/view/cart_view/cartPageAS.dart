import 'package:amazon_flutter/components/search_bar.dart';
import 'package:amazon_flutter/view/cart_view/cartPageBS.dart';
import 'package:amazon_flutter/viewmodel/user_notifier.dart';
import 'package:count_stepper/count_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userVm = Provider.of<UserViewModel>(context);
    return userVm.currentUser != null ? const CartPageAS() : const CartPageBS();
  }
}

class CartPageAS extends StatelessWidget {
  const CartPageAS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SearchBar(isVisible: false,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Subtotal 1000\$",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0,8,18,8),
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text("Proceed to Buy(3 items)"),
                  )),
            )
          ],
        ));
  }
}

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Image.asset("assets/images/sale/png"),
              Column(
                children: const [
                  Text('Tru hair oil Shampoo'),
                  Text("100\$"),
                  Text("In Stock"),
                  Text("sold by Radient_1")
                ],
              ),
            ],
          )),
          Row(
            children: [
              CountStepper(
                iconColor: Theme.of(context).primaryColor,
                defaultValue: 2,
                max: 10,
                min: 1,
                iconDecrementColor: Colors.red,
                splashRadius: 25,
                onPressed: (value) {},
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Delete")),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Save for later"),
              )
            ],
          ),
        ],
      ),
    );
  }
}


