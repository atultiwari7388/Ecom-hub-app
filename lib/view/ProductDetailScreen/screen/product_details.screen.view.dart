import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_hub/common/widgets/custom_bottom_button.widgets.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/ProductDetailScreen/services/product_details.services.product_details.view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../provider/user.provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details-screen';

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsService productDetailsService = ProductDetailsService();

  void addToCart() {
    productDetailsService.addToCart(
      context: context,
      productModel: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = Provider.of<UserProvider>(context).user.cart.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          Center(
            child: Badge(
              badgeColor: kPrimaryColor,
              badgeContent: Text(
                userCartLength.toString(),
                style: TextStyle(color: Colors.white),
              ),
              animationDuration: Duration(milliseconds: 300),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: widget.product.images[0],
            imageBuilder: (context, imageProvider) => Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Lottie.asset("assets/loading.json"),
            ),
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                defaultPadding,
                defaultPadding * 1.5,
                defaultPadding,
                defaultPadding,
              ),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        Text(
                          "\₹" + widget.product.price.toString(),
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    //description
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Text(widget.product.description),
                    ),
                    SizedBox(height: defaultPadding),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomButtonWidget(
        text: "Add to cart",
        onPressed: addToCart,
      ),
    );
  }
}
