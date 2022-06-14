import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_hub/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBarMessage(
        context,
        "Info",
        jsonDecode(response.body)['msg'],
        ContentType.help,
      );
      break;
    case 500:
      showSnackBarMessage(
        context,
        "error",
        jsonDecode(response.body)['error'],
        ContentType.warning,
      );
      break;
    default:
      showSnackBarMessage(
          context, "error", "Something went wrong", ContentType.warning);
  }
}
