import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/settings/appearance_cubit.dart';

class TagInputField extends StatelessWidget {
  const TagInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Insets.appConstantSmall,
          left: Insets.appConstantSmall,
          bottom: Insets.appConstantSmall),
      child: TextField(
        maxLength: 10,
        onChanged: (value) =>
            context.read<AppearanceCubit>().onTagTextChanged(value),
        decoration: InputDecoration(
          labelText: 'Your tag\'s text',
          labelStyle: TextStyle(
            color: Theme.of(context).indicatorColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radii.appConstantSmall),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radii.appConstantSmall),
            borderSide: BorderSide(
              color: Theme.of(context).indicatorColor,
              width: Insets.extraSmall,
            ),
          ),
          counterStyle: const TextStyle(
            height: double.minPositive,
          ),
          counterText: '',
        ),
      ),
    );
  }
}
