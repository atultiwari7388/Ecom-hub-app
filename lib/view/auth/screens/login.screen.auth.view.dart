import 'package:ecom_hub/common/widgets/custom_button.widget.common.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/auth/screens/signup.screen.auth.view.dart';
import 'package:ecom_hub/view/auth/services/auth.services.auth.view.dart';
import 'package:ecom_hub/view/auth/widgets/custom_text_field.widgets.auth.view.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService _authService = AuthService();
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  //signin User
  void signInUser() {
    _authService.signInUser(
      context: context,
      userEmail: _emailController.text,
      userPassword: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //logo
          Expanded(
            child: Container(
              child: Image.asset(
                "assets/icon.png",
                // height: MediaQuery.of(context).size.height * 0.6,
                fit: BoxFit.cover,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  //form
                  Text(
                    "Login in",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: kPrimaryColor, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    imagePath: 'assets/icons/email.svg',
                    keyboardType: TextInputType.emailAddress,
                    svgImageColor: kPrimaryColor,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: _passwordController,
                    svgImageColor: kPrimaryColor,
                    hintText: 'Password',
                    imagePath: 'assets/icons/password.svg',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: defaultPadding * 2),
                  CustomButton(
                    text: "Login in",
                    onTap: () {
                      if (_loginFormKey.currentState!.validate()) {
                        signInUser();
                      }
                    },
                  ),
                  SizedBox(height: defaultPadding * 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        SignUpScreen.routeName,
                        (route) => false,
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
