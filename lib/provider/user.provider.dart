import 'package:ecom_hub/models/users.models.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: "",
    name: "",
    email: "",
    password: "",
    address: "",
    token: "",
    type: "",
    cart: [],
  );

  UserModel get user => _user;

  //set the user
  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
