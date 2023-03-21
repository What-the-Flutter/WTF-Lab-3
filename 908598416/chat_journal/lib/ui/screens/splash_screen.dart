import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/../data/constants/color_constants.dart';
import '/data/providers/auth_provider.dart';
import '../../bloc/cubit/sign_in/sign_in_cubit.dart';
import 'screens.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    final _cubit = BlocProvider.of<SignInCubit>(context);
    super.initState();
    Future.delayed(const Duration(milliseconds: 300),() => _cubit.checkSignedIn(context));
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
