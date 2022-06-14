import 'package:ecom_hub/view/ProductDetailScreen/screen/popular_product_details.screen.view.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/section_title.widgets.common.dart';
import '../../../utils/colors.utils.dart';
import '../widgets/product_card.widget.popular.view.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          onTap: () {},
          title: 'Popular',
        ),
        Container(
          height: 230,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: ProductCard(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(),
                      ),
                    );
                  },
                  image: "assets/images/product_0.png",
                  bgColor: index.isOdd
                      ? Color.fromARGB(255, 38, 97, 96)
                      : Color.fromARGB(255, 222, 234, 234),
                  title: "Long Sleeve Shirt",
                  textColor: index.isOdd ? Colors.black : Colors.white,
                  price: 100,
                  containerBgColor: index.isEven
                      ? Color.fromARGB(255, 38, 97, 96)
                      : Color.fromARGB(255, 222, 234, 234),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
