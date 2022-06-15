import 'package:flutter/material.dart';

import '../../utils/colors.utils.dart';

class CustomBottomButtonWidget extends StatelessWidget {
  const CustomBottomButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding:
          const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
      child: ElevatedButton(
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape: StadiumBorder(),
          elevation: 0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
