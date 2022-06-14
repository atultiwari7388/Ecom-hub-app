import 'package:ecom_hub/routes/app.routes.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/auth/screens/signup.screen.auth.view.dart';
import 'package:ecom_hub/view/home/screens/home.screen.home.view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecom Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: kbgColor,
        fontFamily: "Gordita",
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      onGenerateRoute: (settings) => ongenerateRoute(settings),
      home: SignUpScreen(),
    );
  }
}
