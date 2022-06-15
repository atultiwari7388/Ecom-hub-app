import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/utils/app.utils.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../models/product.models.dart';
import '../../../provider/user.provider.dart';
import '../../../utils/error_handle.utils.dart';

class HomeServices {
  Future<List<ProductModel>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse(AppConstants.App_Url + "api/products?category=$category"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBarMessage(
        context,
        "Error",
        e.toString(),
        ContentType.failure,
      );
      print(e.toString());
    }
    return productList;
  }
}
