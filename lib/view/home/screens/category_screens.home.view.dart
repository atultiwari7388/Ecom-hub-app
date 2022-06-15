import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/PopularProducts/widgets/product_card.widget.popular.view.dart';
import 'package:ecom_hub/view/ProductDetailScreen/screen/product_details.screen.view.dart';
import 'package:ecom_hub/view/home/services/home.services.home.view.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = "/categories-screen";
  const CategoriesScreen({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final HomeServices homeServices = HomeServices();
  List<ProductModel>? productCategoryList;

  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  fetchCategoryProduct() async {
    productCategoryList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          widget.category,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      body: productCategoryList == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: productCategoryList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final productData = productCategoryList![index];
                        return ProductCard(
                          title: productData.name,
                          image: productData.images[0],
                          bgColor: index.isEven
                              ? Color.fromARGB(255, 38, 97, 96)
                              : Color.fromARGB(255, 222, 234, 234),
                          price: double.parse(productData.price.toString()),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.routeName,
                              arguments: productData,
                            );
                          },
                          containerBgColor: index.isOdd
                              ? Color.fromARGB(255, 38, 97, 96)
                              : Color.fromARGB(255, 222, 234, 234),
                          textColor: index.isEven ? Colors.black : Colors.white,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
