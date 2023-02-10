import 'package:flutter/material.dart';

import 'package:my_final_project/init_app.dart';
import 'package:my_final_project/init_blocs.dart';

void main() async {
  final init = await initApp();

  runApp(InitialBlocs(user: init['user']));
}
