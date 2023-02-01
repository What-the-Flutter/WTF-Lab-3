import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../message_filter/cubit/message_filter_cubit.dart';
import '../../message_filter/message_filter.dart';
import '../../message_filter/widget/message_filter_scope.dart';
import '../cubit/message_overview_cubit.dart';
import '../widget/message_overview.dart';
import '../widget/message_overview_scope.dart';
import '../widget/timeline_app_bar.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MessageOverviewScope(
      child: MessageFilterScope(
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: TimelineAppBar(
                onTextChanged:
                    context.read<MessageOverviewCubit>().applySearchQuery,
                onIsFavoriteChanged:
                    context.read<MessageOverviewCubit>().showOnlyFavorites,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: BlocListener<MessageFilterCubit, MessageFilterState>(
                      listener: (context, state) {
                        context.read<MessageOverviewCubit>().applyFilter(
                              context.read<MessageFilterCubit>().filter,
                            );
                      },
                      child: const MessageOverview(),
                    ),
                  ),
                ],
              ),
              floatingActionButton: const FilterFloatingActionButton(),
            );
          },
        ),
      ),
    );
  }
}
