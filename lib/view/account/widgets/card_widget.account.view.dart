import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.utils.dart';

class CustomCardSection extends StatelessWidget {
  const CustomCardSection({
    Key? key,
    required this.cardIcon,
    required this.cardName,
    required this.cardDetails,
    required this.onTap,
  }) : super(key: key);

  final String cardName, cardIcon;
  final int cardDetails;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: kPrimaryLightColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: kPrimaryLightColor,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              //for image
              CircleAvatar(
                backgroundColor: kPrimaryLightColor,
                radius: 30,
                child: SvgPicture.asset(
                  cardIcon,
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              //for text
              Text(
                cardName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.grey.shade400),
              ),
              SizedBox(height: 10),

              Text(
                cardDetails.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.black),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
