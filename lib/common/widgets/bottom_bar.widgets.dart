import 'package:badges/badges.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/account/screens/account.screens.account.view.dart';
import 'package:ecom_hub/view/cart/screens/cart.screen.cart.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../provider/user.provider.dart';
import '../../view/home/screens/home.screen.home.view.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    AccountScreen(),
    Container(
      child: Center(
        child: Text("Favorite Screen"),
      ),
    ),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kbgColor,
        currentIndex: _page,
        onTap: updatePage,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: _page == 0 ? Icon(IconlyBold.home) : Icon(IconlyLight.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _page == 1
                ? Icon(IconlyBold.profile)
                : Icon(IconlyLight.profile),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _page == 2 ? Icon(IconlyBold.heart) : Icon(IconlyLight.heart),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              badgeColor: kPrimaryColor,
              badgeContent: Text(
                userCartLen.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: _page == 3 ? Icon(IconlyBold.buy) : Icon(IconlyLight.buy),
            ),
            label: "",
          ),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _page,
      //   selectedItemColor: kPrimaryColor,
      //   unselectedItemColor: kPrimaryColor.withOpacity(0.5),
      //   backgroundColor: kbgColor,
      //   iconSize: 28,
      //   onTap: updatePage,
      //   items: [
      //     // HOME
      //     BottomNavigationBarItem(
      //       icon: Container(
      //         width: bottomBarWidth,
      //         decoration: BoxDecoration(
      //           border: Border(
      //             top: BorderSide(
      //               color: _page == 0 ? kPrimaryColor : kbgColor,
      //               width: bottomBarBorderWidth,
      //             ),
      //           ),
      //         ),
      //         child: _page == 0
      //             ? Icon(
      //                 IconlyBold.home,
      //               )
      //             : Icon(IconlyLight.home),
      //       ),
      //       label: '',
      //     ),
      //     //heart
      //     BottomNavigationBarItem(
      //       icon: Container(
      //         width: bottomBarWidth,
      //         decoration: BoxDecoration(
      //           border: Border(
      //             top: BorderSide(
      //               color: _page == 1 ? kPrimaryColor : kbgColor,
      //               width: bottomBarBorderWidth,
      //             ),
      //           ),
      //         ),
      //         child: const Icon(
      //           Icons.person_outline_outlined,
      //         ),
      //       ),
      //       label: '',
      //     ),
      //     // Account
      //     BottomNavigationBarItem(
      //       icon: Container(
      //         width: bottomBarWidth,
      //         decoration: BoxDecoration(
      //           border: Border(
      //             top: BorderSide(
      //               color: _page == 2 ? kPrimaryColor : kbgColor,
      //               width: bottomBarBorderWidth,
      //             ),
      //           ),
      //         ),
      //         child: const Icon(
      //           Icons.person_outline_outlined,
      //         ),
      //       ),
      //       label: '',
      //     ),
      //     // CART
      //     BottomNavigationBarItem(
      //       icon: Container(
      //         width: bottomBarWidth,
      //         decoration: BoxDecoration(
      //           border: Border(
      //             top: BorderSide(
      //               color: _page == 2 ? kPrimaryColor : kbgColor,
      //               width: bottomBarBorderWidth,
      //             ),
      //           ),
      //         ),
      //         child: Badge(
      //           elevation: 0,
      //           badgeContent: Text(userCartLen.toString()),
      //           badgeColor: Colors.white,
      //           child: const Icon(
      //             Icons.shopping_cart_outlined,
      //           ),
      //         ),
      //       ),
      //       label: '',
      //     ),
      //   ],
      // ),
    );
  }
}
