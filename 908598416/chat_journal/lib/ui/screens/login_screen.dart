import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/../data/constants/app_constants.dart';
import '/../data/constants/color_constants.dart';
import '../../bloc/cubit/sign_in/sign_in_cubit.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _authCubit = BlocProvider.of<SignInCubit>(context);
    final _state = _authCubit.state;

    if (_state is AuthenticateError) {
      Fluttertoast.showToast(msg: 'Sign in fail');
    } else if (_state is AuthenticateCanceled) {
      Fluttertoast.showToast(msg: 'Sign in canceled');
    } else if (_state is Authenticated) {
      Fluttertoast.showToast(msg: 'Sign in success');
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
                  _authCubit.handleSignIn().then((isSuccess) {
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
                    _authCubit.handleException();
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
              child: _state is AuthenticationInProgress
                  ? LoadingView()
                  : const SizedBox.shrink(),
            ),
          ],
        ));
  }
}
