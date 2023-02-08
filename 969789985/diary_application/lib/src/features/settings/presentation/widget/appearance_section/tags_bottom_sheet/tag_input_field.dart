import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/appearance_cubit.dart';

class TagInputField extends StatelessWidget {
  const TagInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.appConstantSmall),
      child: TextField(
        maxLength: 10,
        onChanged: (value) =>
            context.read<AppearanceCubit>().onTagTextChanged(value),
        decoration: InputDecoration(
          labelText: 'Your tag\'s text',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radii.circle),
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
