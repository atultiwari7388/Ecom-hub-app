import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/view/PopularProducts/services/popular_product.service.dart';
import 'package:ecom_hub/view/ProductDetailScreen/screen/product_details.screen.view.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/section_title.widgets.common.dart';
import '../../../utils/colors.utils.dart';
import '../widgets/product_card.widget.popular.view.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  ProductModel? productModel;
  final PopularProductDetailsServices _popularProductDetailsServices =
      PopularProductDetailsServices();

  @override
  void initState() {
    super.initState();
    fetchMostRatingProducts();
  }

  fetchMostRatingProducts() async {
    productModel = await _popularProductDetailsServices.fetchDealOfDay(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return productModel == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              SectionTitle(
                onTap: () {},
                title: 'Popular',
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productModel!.images
                      .map(
                        (e) => Container(
                          height: 230,
                          child: ProductCard(
                            title: productModel!.name,
                            image: e,
                            bgColor: kPrimaryLightColor,
                            price: productModel!.price,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailsScreen.routeName,
                                arguments: productModel!,
                              );
                            },
                            containerBgColor: kPrimaryLightColor,
                            textColor: kPrimaryColor,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              // Container(
              //   height: 230,
              //   child: ListView.builder(
              //     itemCount: 2,
              //     scrollDirection: Axis.horizontal,
              //     physics: BouncingScrollPhysics(),
              //     itemBuilder: (BuildContext context, int index) {
              //       return Padding(
              //         padding: const EdgeInsets.only(left: defaultPadding),
              //         child: ProductCard(
              //           onTap: () {},
              //           image: productModel!.images[0],
              //           bgColor: index.isOdd
              //               ? Color.fromARGB(255, 38, 97, 96)
              //               : Color.fromARGB(255, 222, 234, 234),
              //           title: productModel!.name[index],
              //           textColor: index.isOdd ? Colors.black : Colors.white,
              //           price: 100,
              //           containerBgColor: index.isEven
              //               ? Color.fromARGB(255, 38, 97, 96)
              //               : Color.fromARGB(255, 222, 234, 234),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          );
  }
}
