import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/timeline/timeline_cubit.dart';
import '../../widget/timeline/filter/filter_body.dart';
import '../../widget/timeline/scope/timeline_scope.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                TimelineScope.of(context).updateMode(false);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  TimelineScope.of(context).updateMode(true);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
          body: const FilterBody(),
        );
      },
    );
  }
}
