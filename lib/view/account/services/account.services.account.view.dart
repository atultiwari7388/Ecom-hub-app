import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/models/orders.models.dart';
import 'package:ecom_hub/utils/app.utils.dart';
import 'package:ecom_hub/utils/error_handle.utils.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:ecom_hub/view/auth/screens/login.screen.auth.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../provider/user.provider.dart';

class AccountServices {
  //ferch orders

  Future<List<OrderModel>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context);
    List<OrderModel> ordereList = [];
    try {
      http.Response response =
          await http.get(Uri.parse(AppConstants.FETCH_MY_ORDERS), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        AppConstants.TOKEN: userProvider.user.token,
      });

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            ordereList.add(OrderModel.fromJson(
              jsonEncode(
                jsonDecode(
                  response.body[i],
                ),
              ),
            ));
          }
        },
      );
    } catch (e) {
      showSnackBarMessage(context, "Error", e.toString(), ContentType.failure);
    }
    return ordereList;
  }

  //logout
  void logOutApp(BuildContext context) async {
    try {
      //get the instance of shared preferences
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(AppConstants.TOKEN, "");
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
      showSnackBarMessage(context, "LogOut", "", ContentType.success);
    } catch (e) {
      showSnackBarMessage(context, "Error", e.toString(), ContentType.failure);
    }
  }
}
