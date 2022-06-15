import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/models/users.models.dart';
import 'package:ecom_hub/utils/app.utils.dart';
import 'package:ecom_hub/utils/error_handle.utils.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../provider/user.provider.dart';

class ProductDetailsService {
  //add to cart

  void addToCart({
    required BuildContext context,
    required ProductModel productModel,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      //make http request

      http.Response response = await http.post(
        Uri.parse(AppConstants.ADD_TO_CART),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.TOKEN: userProvider.user.token,
        },
        body: jsonEncode({"id": productModel.id!}),
      );

      //handle the errors

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          UserModel user = userProvider.user
              .copyWith(cart: jsonDecode(response.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBarMessage(context, "Error", e.toString(), ContentType.failure);
    }
  }
}
