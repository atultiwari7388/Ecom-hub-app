import 'package:flutter/material.dart';

import '../../../utils/colors.utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.title,
    required this.image,
    required this.bgColor,
    required this.price,
    required this.onTap,
    required this.containerBgColor,
    required this.textColor,
  }) : super(key: key);

  final String image, title;
  final Color bgColor, containerBgColor, textColor;
  final double price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: EdgeInsets.all(defaultPadding / 2),
        decoration: BoxDecoration(
          color: containerBgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image section
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultPadding),
                ),
              ),
              child: Image.network(
                image,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: textColor),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: defaultPadding / 4),
                Text(
                  "\₹" + price.toString(),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
