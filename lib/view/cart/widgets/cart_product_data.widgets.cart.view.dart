import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_hub/common/widgets/custom_box_shape_button.widgets.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/provider/user.provider.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/ProductDetailScreen/services/product_details.services.product_details.view.dart';
import 'package:ecom_hub/view/cart/services/cart.services.cart.view.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:provider/provider.dart';

class CartProductData extends StatefulWidget {
  final int index;
  const CartProductData({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProductData> createState() => _CartProductDataState();
}

class _CartProductDataState extends State<CartProductData> {
  ProductDetailsService productDetailsService = ProductDetailsService();
  CartServices cartServices = CartServices();

  void increaseQuantity(ProductModel product) {
    productDetailsService.addToCart(context: context, productModel: product);
  }

  void decreaseQuantity(ProductModel product) {
    cartServices.removeFromCart(context: context, productModel: product);
  }

  @override
  Widget build(BuildContext context) {
    // create a reference to the user provider
    final cartProduct =
        Provider.of<UserProvider>(context).user.cart[widget.index];
    // create a reference to the productModel
    final productModel = ProductModel.fromMap(cartProduct["product"]);
    final productQuantity = cartProduct["quantity"];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //image Section
              CachedNetworkImage(
                imageUrl: productModel.images[0],
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 35,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => GFShimmer(
                  child: CircleAvatar(
                    radius: 35,
                  ),
                ),
              ),
              SizedBox(width: 5),

              //product name section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productModel.name),
                  Text("₹" + productModel.price.toString()),
                ],
              ),
              //quantity section
              // SizedBox(width: defaultPadding),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(productModel),
                      child: CustomBoxShapeWidget(
                          icon: Icons.remove, iconColor: kPrimaryColor),
                    ),
                    SizedBox(width: 10),
                    Text(productQuantity.toString()),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () => increaseQuantity(productModel),
                      child: CustomBoxShapeWidget(
                        icon: Icons.add,
                        iconColor: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
