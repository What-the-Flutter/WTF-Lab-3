import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/main/start_screen_cubit.dart';
import '../../chatter/chatter_main/chatter_list/chatter_list.dart';
import '../scope/main_scope.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartScreenCubit, StartScreenState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: Insets.appConstantMedium),
            Expanded(
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    if (!state.fabVisible) {
                      StartScreenScope.of(context).fabVisible = true;
                    }
                    if(!state.gNavVisible) {
                      StartScreenScope.of(context).gNavVisible = true;
                    }
                  } else if (notification.direction ==
                      ScrollDirection.reverse) {
                    if (state.fabVisible) {
                      StartScreenScope.of(context).fabVisible = false;
                    }
                    if(state.gNavVisible) {
                      StartScreenScope.of(context).gNavVisible = false;
                    }
                  }

                  return true;
                },
                child: ChatterList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
