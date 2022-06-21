import 'package:flutter/material.dart';

import '../../../common/widgets/custom_row_text_widget.dart';
import '../../../models/users.models.dart';
import '../../../utils/colors.utils.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({
    Key? key,
    required this.userInformation,
  }) : super(key: key);

  final UserModel userInformation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      child: Container(
        height: 160,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: kPrimaryLightColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            CustomRowTextWidget(
              text: "Name:",
              text2: userInformation.name,
            ),
            SizedBox(height: defaultPadding),
            CustomRowTextWidget(
              text: "Email:",
              text2: userInformation.email,
            ),
            SizedBox(height: defaultPadding),
            CustomRowTextWidget(
              text: "Address:",
              text2: userInformation.address.isEmpty
                  ? "Not Provided"
                  : userInformation.address,
            ),
          ],
        ),
      ),
    );
  }
}
