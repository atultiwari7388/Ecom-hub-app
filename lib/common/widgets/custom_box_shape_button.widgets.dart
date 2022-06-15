import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:flutter/material.dart';

class CustomBoxShapeWidget extends StatelessWidget {
  const CustomBoxShapeWidget({
    Key? key,
    required this.icon,
    this.iconColor = Colors.black,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45 - 3,
      width: 45 - 3,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}
