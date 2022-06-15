import 'package:ecom_hub/common/widgets/custom_bottom_button.widgets.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/cart/widgets/cart_product_data.widgets.cart.view.dart';
import 'package:ecom_hub/view/cart/widgets/subtotal.widgets.cart.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user.provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    print(MediaQuery.of(context).size.height.toString());
    print(MediaQuery.of(context).size.width.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: ThemeData().iconTheme.copyWith(color: kPrimaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        itemCount: user.cart.length,
        itemBuilder: (BuildContext context, int index) {
          return CartProductData(index: index);
        },
      ),
      bottomNavigationBar: Container(
        height: 100,
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CartSubTotal(),
            SizedBox(height: 5),
            CustomBottomButtonWidget(
              text: "Checkout",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
