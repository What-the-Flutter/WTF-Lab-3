import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/message_filter_cubit.dart';
import '../view/message_filter.dart';
import 'message_filter_scope.dart';

class FilterFloatingActionButton extends StatelessWidget {
  const FilterFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageFilterCubit, MessageFilterState>(
      builder: (context, state) {
        return badges.Badge(
          showBadge: state.amountOfSelected != 0,
          badgeContent: Text(
            state.amountOfSelected.toString(),
          ),
          child: FloatingActionButton(
            child: const Icon(
              Icons.filter_list_outlined,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => MessageFilter(
                  cubit: context.read<MessageFilterCubit>(),
                ),
                isScrollControlled: true,
                useRootNavigator: true,
              );
            },
          ),
        );
      },
    );
  }
}
