import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<EventCubit>().changeFavoriteItem(),
      child: const Icon(
        Icons.turned_in_not,
        color: Colors.white,
      ),
    );
  }
}
