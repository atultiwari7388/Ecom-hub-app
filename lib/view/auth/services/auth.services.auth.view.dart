import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/common/widgets/bottom_bar.widgets.dart';
import 'package:ecom_hub/models/users.models.dart';
import 'package:ecom_hub/provider/user.provider.dart';
import 'package:ecom_hub/utils/app.utils.dart';
import 'package:ecom_hub/utils/error_handle.utils.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:ecom_hub/view/auth/screens/login.screen.auth.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //create signup function

  void signUpUser({
    required BuildContext context,
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      UserModel userModel = UserModel(
        id: "",
        name: userName,
        email: userEmail,
        password: userPassword,
        address: "",
        token: "",
        type: "",
        cart: [],
      );

      //create post request

      http.Response response = await http.post(
        Uri.parse(AppConstants.SIGN_UP),
        body: userModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      //handle the errors
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBarMessage(
              context,
              "Success",
              "Account created successfully ! Login with same credentials",
              ContentType.success,
            );

            //Navigate to login screen

            Navigator.pushNamed(context, LoginScreen.routeName);

            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   BottomBar.routeName,
            //   (route) => false,
            // );
          });
      // print(response.body);
    } catch (e) {
      showSnackBarMessage(
        context,
        "Error",
        e.toString(),
        ContentType.warning,
      );
    }
  }

  //create signin function
  void signInUser({
    required BuildContext context,
    required userEmail,
    required userPassword,
  }) async {
    try {
      //http request

      http.Response response = await http.post(
        Uri.parse(AppConstants.SIGN_IN),
        body: jsonEncode({"email": userEmail, "password": userPassword}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          //we need to store the token in phone memory
          SharedPreferences pref = await SharedPreferences.getInstance();

          //set the token
          await pref.setString(
            AppConstants.TOKEN,
            jsonDecode(response.body)["token"],
          );
          //set the user type
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);

          showSnackBarMessage(
            context,
            "${Provider.of<UserProvider>(context, listen: false).user.name}",
            "Welcome back ${Provider.of<UserProvider>(context, listen: false).user.name}",
            ContentType.success,
          );

          //Navigate to home Page
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   BottomBar.routeName,
          //   (route) => false,
          // );
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );

          // print(response.body);
        },
      );
    } catch (e) {
      showSnackBarMessage(
        context,
        "Error",
        e.toString(),
        ContentType.warning,
      );
    }
  }

  //get user data
  //get the user from the phone memory

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppConstants.TOKEN);

      if (token == null) {
        prefs.setString(AppConstants.TOKEN, "");
      }

      var tokenRes = await http.post(
        Uri.parse(AppConstants.TOKEN_IS_VALID),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.TOKEN: token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data
        http.Response userResponse = await http.get(
          Uri.parse(AppConstants.App_Url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            AppConstants.TOKEN: token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      print(e.toString());
      showSnackBarMessage(
        context,
        "Error",
        e.toString(),
        ContentType.warning,
      );
    }
  }
}
