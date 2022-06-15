import 'package:ecom_hub/provider/user.provider.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    //map through the cart items and add the price to the sum

    user.cart
        .map((e) => sum += e['quantity'] * e["product"]["price"] as int)
        .toList();

    return Container(
      margin: const EdgeInsets.all(defaultPadding - 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Subtotal",
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Text(
            "₹" + sum.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
