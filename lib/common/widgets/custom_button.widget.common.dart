import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            color: color == null ? Colors.white : Colors.white,
          ),
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: StadiumBorder(),
          primary: color == null ? kPrimaryColor : color,
        ),
      ),
    );
  }
}
