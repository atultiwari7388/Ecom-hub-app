import 'package:ecom_hub/provider/user.provider.dart';
import 'package:ecom_hub/routes/app.routes.dart';
import 'package:ecom_hub/utils/colors.utils.dart';
import 'package:ecom_hub/view/auth/screens/signup.screen.auth.view.dart';
import 'package:ecom_hub/view/auth/services/auth.services.auth.view.dart';
import 'package:ecom_hub/view/home/screens/home.screen.home.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

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
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomeScreen()
          : SignUpScreen(),
    );
  }
}
