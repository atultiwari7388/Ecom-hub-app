import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:flutter/material.dart';

class CustomRowTextWidget extends StatelessWidget {
  const CustomRowTextWidget({Key? key, required this.text, required this.text2})
      : super(key: key);
  final String text, text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.black54),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text2,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
