import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/ProductDetailScreen/screen/product_details.screen.view.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import '../services/search.service.serach.view.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: kPrimaryColor),
        title: RichText(
          text: TextSpan(
            text: "Search for ",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.black54),
            children: [
              TextSpan(
                text: '  "${widget.searchQuery}"',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? Center(
              child: Lottie.asset(
                "assets/search_product.json",
                repeat: true,
              ),
            )
          : products!.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/not-found.json",
                      repeat: true,
                      reverse: false,
                    ),
                    SizedBox(height: defaultPadding),
                    RichText(
                      text: TextSpan(
                        text: "No results found for ",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: '  "${widget.searchQuery}"',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    final searchProductData = products![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: searchProductData,
                        );
                      },
                      // ignore: unnecessary_null_comparison
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: searchProductData.images[0],
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                  radius: 35, backgroundImage: imageProvider),
                          placeholder: (context, url) => GFShimmer(
                            mainColor: kPrimaryLightColor,
                            secondaryColor: kbgColor,
                            child: CircleAvatar(
                              radius: 35,
                            ),
                          ),
                        ),
                        title: Text(
                          searchProductData.name,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        subtitle: Text(
                          searchProductData.category,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
