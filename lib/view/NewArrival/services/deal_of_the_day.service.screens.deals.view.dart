import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/models/product.models.dart';
import 'package:ecom_hub/provider/user.provider.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app.utils.dart';
import '../../../utils/error_handle.utils.dart';

class DealsOfTheDayServices {
  //fetch deal of the day
  Future<ProductModel> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response res = await http
          .get(Uri.parse(AppConstants.App_Url + 'api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = ProductModel.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBarMessage(
        context,
        "Error",
        e.toString(),
        ContentType.failure,
      );
    }
    return product;
  }
}
