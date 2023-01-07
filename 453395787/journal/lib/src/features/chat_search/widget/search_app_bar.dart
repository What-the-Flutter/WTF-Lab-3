import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_search_cubit.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        onChanged: (value) => context.read<ChatSearchCubit>().search(value),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
