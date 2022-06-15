//categories widget
import 'package:ecom_hub/common/widgets/global_var.dart';
import 'package:ecom_hub/view/home/screens/category_screens.home.view.dart';
import 'package:ecom_hub/view/home/widgets/category_card.widget.home.view.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.utils.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  void navigateTocategoriesScreen(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoriesScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        itemCount: Globalvariables.categoryItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final categoryData = Globalvariables.categoryItems[index];
          return Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: CategoryCard(
              icon: categoryData["image"]!,
              title: categoryData["title"]!,
              onTap: () => navigateTocategoriesScreen(
                context,
                categoryData['title']!,
              ),
            ),
          );
        },
      ),
    );
  }
}
