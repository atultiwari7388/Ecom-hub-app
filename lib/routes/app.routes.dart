import 'package:ecom_hub/common/widgets/bottom_bar.widgets.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/view/ProductDetailScreen/screen/product_details.screen.view.dart';
import 'package:ecom_hub/view/account/screens/account.screens.account.view.dart';
import 'package:ecom_hub/view/address/screens/address.screens.address.view.dart';
import 'package:ecom_hub/view/auth/screens/signup.screen.auth.view.dart';
import 'package:ecom_hub/view/home/screens/category_screens.home.view.dart';
import 'package:ecom_hub/view/home/screens/home.screen.home.view.dart';
import 'package:flutter/material.dart';
import '../view/Orders/screens/orders.screens.orders.view.dart';
import '../view/auth/screens/login.screen.auth.view.dart';
import '../view/search/screens/search.screen.search.view.dart';

Route<dynamic> ongenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => SignUpScreen(),
      );

    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (context) => BottomBar(),
      );

    case CategoriesScreen.routeName:
      var category = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => CategoriesScreen(category: category),
      );

    case ProductDetailsScreen.routeName:
      var product = settings.arguments as ProductModel;
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: product,
        ),
      );

    case SearchScreen.routeName:
      var searchQuery = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    case AddressScreen.routeName:
      var totalAmount = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );

    case AccountScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AccountScreen(),
      );

    case OrderScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => OrderScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
