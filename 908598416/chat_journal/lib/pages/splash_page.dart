import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../providers/auth_provider.dart';
import 'pages.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), checkSignedIn);
  }

  void checkSignedIn() async {
    var authProvider = context.read<AuthProvider>();
    var isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/app_icon.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            Container(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(
                  color: ColorConstants.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}
