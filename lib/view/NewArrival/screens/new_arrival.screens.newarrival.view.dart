import 'package:ecom_hub/common/widgets/section_title.widgets.common.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.utils.dart';
import '../../PopularProducts/widgets/product_card.widget.popular.view.dart';

class NewArrival extends StatelessWidget {
  const NewArrival({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          onTap: () {},
          title: 'New Arrived',
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
                  image: "assets/images/product_0.png",
                  bgColor: index.isEven
                      ? Color.fromARGB(255, 38, 97, 96)
                      : Color.fromARGB(255, 222, 234, 234),
                  title: "Long Sleeve Shirt",
                  textColor: index.isEven ? Colors.black : Colors.white,
                  price: 100,
                  containerBgColor: index.isOdd
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
