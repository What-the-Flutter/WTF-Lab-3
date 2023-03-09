import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../constants/color_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    switch (_authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in fail');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in canceled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in success');
        break;
      default:
        break;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            AppConstants.loginTitle,
            style: TextStyle(color: ColorConstants.primaryColor),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: TextButton(
                onPressed: () async {
                  _authProvider.handleSignIn().then((isSuccess) {
                    if (isSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  }).catchError((error, stackTrace) {
                    Fluttertoast.showToast(msg: error.toString());
                    _authProvider.handleException();
                  });
                },
                child: const Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xffdd4b39).withOpacity(0.8);
                      }
                      return const Color(0xffdd4b39);
                    },
                  ),
                  splashFactory: NoSplash.splashFactory,
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  ),
                ),
              ),
            ),
            // Loading
            Positioned(
              child: _authProvider.status == Status.authenticating
                  ? LoadingView()
                  : const SizedBox.shrink(),
            ),
          ],
        ));
  }
}
