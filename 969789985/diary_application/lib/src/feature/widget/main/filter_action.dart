import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/main/start_screen_cubit.dart';
import '../../page/filter/filter_page.dart';
import '../timeline/scope/timeline_scope.dart';
import 'scope/main_scope.dart';

class FilterAction extends StatelessWidget {
  const FilterAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartScreenCubit, StartScreenState>(
      builder: (context, state) {
        return AnimatedScale(
          scale: state.pageIndex == 1 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 150),
          child: IconButton(
            onPressed: () {
              TimelineScope.of(context).updateMode(false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterPage(),
                ),
              );
            },
            icon: const Icon(Icons.filter_list_outlined),
          ),
        );
      },
    );
  }
}
