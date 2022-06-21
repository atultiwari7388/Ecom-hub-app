import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:provider/provider.dart';
import '../../../provider/user.provider.dart';
import '../../PopularProducts/screens/popular_product.screens.popular.view.dart';
import '../widgets/categories.widgets.home.view.dart';
import '../widgets/search.widgets.home.view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userCartLength = Provider.of<UserProvider>(context).user.cart.length;
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: SvgPicture.asset("assets/icons/menu.svg"),
        // ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: defaultPadding / 2),
            Text(
              "Ecom hub",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
        actions: [
          // GestureDetector(
          //   onTap: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (_) => CartScreen(),
          //     ),
          //   ),
          //   child: Center(
          //     child: Badge(
          //       badgeColor: kPrimaryColor,
          //       badgeContent: Text(
          //         userCartLength.toString(),
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       animationDuration: Duration(milliseconds: 300),
          //       child: Icon(
          //         Icons.shopping_cart_outlined,
          //         color: Colors.black,
          //         size: 28,
          //       ),
          //     ),
          //   ),
          // ),
          //
          SvgPicture.asset(
            "assets/icons/Notification.svg",
            color: Colors.black54,
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top heading section
              Text(
                "Explore",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              Text(
                "Best deals for you",
                style: TextStyle(fontSize: 18.0),
              ),

              //search bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: SearchFormWidget(),
              ),
              //category section
              Categories(),
              //new Arrival section
              SizedBox(height: defaultPadding),
              //new arrival
              // NewArrival(),
              // SizedBox(height: defaultPadding),
              PopularProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
