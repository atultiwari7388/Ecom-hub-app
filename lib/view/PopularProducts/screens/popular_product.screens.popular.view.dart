import 'package:ecom_hub/view/PopularProducts/services/popular_product.service.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/section_title.widgets.common.dart';
import '../../../models/product.models.dart';
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
                  onTap: () {},
                  image:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpurepng.com%2Fpublic%2Fuploads%2Flarge%2Fpurepng.com-sky-blue-t-shirtclothingt-shirtt-shirtdressfashionclothshirt-691522330544ifxvx.png&f=1&nofb=1",
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
