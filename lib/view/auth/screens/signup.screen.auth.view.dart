import 'package:ecom_hub/common/widgets/custom_button.widget.common.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/auth/screens/login.screen.auth.view.dart';
import 'package:ecom_hub/view/auth/services/auth.services.auth.view.dart';
import 'package:ecom_hub/view/auth/widgets/custom_text_field.widgets.auth.view.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _authService = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  //signup User
  void signUpUser() {
    _authService.signUpUser(
      context: context,
      userName: _nameController.text,
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
              key: _signUpFormKey,
              child: Column(
                children: [
                  //form
                  Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: kPrimaryColor, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Name',
                    imagePath: 'assets/icons/person.svg',
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    imagePath: 'assets/icons/email.svg',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    imagePath: 'assets/icons/password.svg',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: defaultPadding * 2),
                  _isLoading
                      ? CircularProgressIndicator(color: kPrimaryColor)
                      : CustomButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                              setState(() {
                                _isLoading = true;
                              });
                            }
                          },
                        ),
                  SizedBox(height: defaultPadding * 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
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
                            text: "Sign In",
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
