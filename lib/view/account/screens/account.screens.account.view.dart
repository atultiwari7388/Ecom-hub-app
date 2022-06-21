import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/common/widgets/section_title.widgets.common.dart';
import 'package:ecom_hub/models/users.models.dart';
import 'package:ecom_hub/provider/user.provider.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:ecom_hub/view/Orders/screens/orders.screens.orders.view.dart';
import 'package:ecom_hub/view/account/services/account.services.account.view.dart';
import 'package:ecom_hub/view/account/widgets/card_widget.account.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../widgets/personal_information.widget.account.view.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/account-screen';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountServices accountServices = AccountServices();

  navigateToOrderScreen() {
    Navigator.of(context).pushNamed(OrderScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final userInformation = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       title: Text(
              //         'Logout',
              //         style: Theme.of(context).textTheme.headline6!.copyWith(
              //               color: kPrimaryColor,
              //             ),
              //       ),
              //       content: Text(
              //         'Are you sure you want to quit the app?',
              //         style: Theme.of(context)
              //             .textTheme
              //             .subtitle1!
              //             .copyWith(color: Colors.black54),
              //       ),
              //       actions: [
              //         TextButton(
              //           child: Text('No'),
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //         ),
              //         TextButton(
              //           child: Text('Yes', style: TextStyle(color: Colors.red)),
              //           onPressed: () {
              //             accountServices.logOutApp(context);
              //             Navigator.pop(context);
              //           },
              //         ),
              //       ],
              //     );
              //   },
              // );

              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      title: Text(
                        'Are you sure you want to logout?',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.w500),
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          child:
                              Text('Yes', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Navigator.pop(context);
                            accountServices.logOutApp(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(
              IconlyBold.logout,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //profile section
              ProfileSection(userInformation: userInformation),
              SizedBox(height: 30),
              //card section
              Wrap(
                direction: Axis.horizontal,
                children: [
                  CustomCardSection(
                    cardIcon: 'assets/icons/orders.svg',
                    cardName: "My Orders",
                    cardDetails: 0,
                    onTap: navigateToOrderScreen,
                  ),
                  CustomCardSection(
                    cardIcon: 'assets/icons/promocode.svg',
                    cardName: "Promocodes",
                    cardDetails: 2,
                    onTap: () {
                      showSnackBarMessage(context, "PromoCodes",
                          "Currently not available ", ContentType.help);
                    },
                  ),
                  CustomCardSection(
                    cardIcon: 'assets/icons/star.svg',
                    cardName: "Reviews",
                    cardDetails: 10,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 30),
              //personal details
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Personal Information",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              PersonalInformation(userInformation: userInformation),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    Key? key,
    required this.userInformation,
  }) : super(key: key);

  final UserModel userInformation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(
            backgroundColor: Colors.black38,
            radius: 50,
            backgroundImage: AssetImage("assets/user_icon.png"),
          ),
        ),
        SizedBox(height: 20),
        Text(
          userInformation.name,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Text(
          userInformation.email,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
