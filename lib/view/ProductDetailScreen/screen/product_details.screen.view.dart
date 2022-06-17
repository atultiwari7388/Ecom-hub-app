import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_hub/common/widgets/custom_bottom_button.widgets.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/ProductDetailScreen/services/product_details.services.product_details.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

  //initialize the product rating

  double avgRating = 0;
  double myRating = 0.0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = (totalRating / widget.product.rating!.length);
    }
  }

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: defaultPadding / 2),
                              RatingBarIndicator(
                                direction: Axis.horizontal,
                                itemCount: 5,
                                rating: avgRating,
                                itemSize: 15,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\₹" +
                                  double.parse("${widget.product.price}")
                                      .toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              avgRating.toString(),
                            ),
                          ],
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
                    //product Rate

                    //rate the product
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Text(
                        "Rate the product",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: myRating,
                      minRating: 2.5,
                      direction: Axis.horizontal,
                      itemSize: 30,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: kPrimaryColor,
                      ),
                      onRatingUpdate: (rating) {
                        productDetailsService.rateProduct(
                          context: context,
                          productModel: widget.product,
                          productRating: rating,
                        );
                      },
                    )
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
