//categories widget
import 'package:ecom_hub/view/home/widgets/category_card.widget.home.view.dart';
import 'package:flutter/material.dart';

import '../../../models/category.models.dart';
import '../../../utils/colors.utils.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final categoryData = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: CategoryCard(
              icon: categoryData.icon,
              title: categoryData.title,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
