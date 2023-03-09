import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/main/start_screen_cubit.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../../page/chatter/chatter_new_page.dart';
import '../theme/theme_scope.dart';

class FabButton extends StatelessWidget {
  const FabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, tState) {
        return BlocBuilder<StartScreenCubit, StartScreenState>(
          builder: (context, state) {
            return AnimatedSlide(
              curve:
                  state.fabVisible ? Curves.fastOutSlowIn : Curves.decelerate,
              duration: const Duration(milliseconds: 400),
              offset: state.fabVisible ? Offset.zero : const Offset(0, 2),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: state.fabVisible ? 1 : 0,
                child: FloatingActionButton(
                  backgroundColor:
                      Color(ThemeScope.of(context).state.primaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewChatScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
