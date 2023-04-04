import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectInfoBox extends StatelessWidget {
  final String text;

  const SelectInfoBox({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Align(
        alignment: const Alignment(0, -1),
        child: Container(
          decoration: BoxDecoration(
            color: BlocProvider.of<SettingsCubit>(context).isDark
                ? const Color.fromRGBO(37, 47, 57, 1)
                : const Color.fromRGBO(77, 157, 206, 0.7),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: BlocProvider.of<SettingsCubit>(context).isDark
                        ? Colors.grey
                        : Colors.white,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
