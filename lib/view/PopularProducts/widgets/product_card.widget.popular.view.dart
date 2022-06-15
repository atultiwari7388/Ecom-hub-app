import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

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
            CachedNetworkImage(
                imageUrl: image,
                imageBuilder: (context, imageProvider) => Container(
                      height: 130,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(defaultPadding),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                placeholder: (context, url) => GFShimmer(
                      mainColor: kPrimaryColor,
                      secondaryColor: kPrimaryLightColor,
                      child: Container(
                        height: 130,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(defaultPadding),
                          ),
                        ),
                      ),
                    )),
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
