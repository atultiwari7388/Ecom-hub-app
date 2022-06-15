import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = '/product-details-screen';

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: product.images[0],
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
                            product.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        Text(
                          "\₹" + product.price.toString(),
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
                      child: Text(product.description),
                    ),
                    SizedBox(height: defaultPadding),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        padding:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        child: ElevatedButton(
          child: Text("Add To cart"),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            shape: StadiumBorder(),
            elevation: 0,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
