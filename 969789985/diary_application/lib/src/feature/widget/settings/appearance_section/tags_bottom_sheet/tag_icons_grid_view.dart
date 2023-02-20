import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../cubit/settings/appearance_cubit.dart';
import '../../../theme/theme_scope.dart';

class TagIconsGridView extends StatelessWidget {
  final AppearanceState state;

  const TagIconsGridView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(Insets.appConstantSmall),
        child: GridView.count(
          crossAxisCount: 5,
          children: [
            for (var index = 0; index < possibleIcons.length; index++)
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(ThemeScope.of(context).state.primaryItemColor),
                      ),
                    ),
                    onPressed: () {
                      context.read<AppearanceCubit>().selectTagIcon(
                            index,
                            possibleIcons[index],
                          );
                    },
                    icon: Icon(
                      IconData(
                        possibleIcons[index],
                        fontFamily: AppIcons.material,
                      ),
                      size: IconsSize.large,
                    ),
                  ),
                 Container(
                   width: Insets.extraSmall,
                   height: Insets.extraSmall,
                   child:  Padding(
                     padding: const EdgeInsets.only(
                       left: Insets.large * 1.5,
                       top: Insets.appConstantLarge * 1.1,
                     ),
                     child: Transform.scale(
                       scale: Insets.extraSmall * 0.7,
                       child: Checkbox(
                         splashRadius: Insets.none,
                         side: MaterialStateBorderSide.resolveWith(
                                 (states) => BorderSide.none),
                         activeColor: Colors.transparent,
                         fillColor: MaterialStateColor.resolveWith(
                               (states) => Colors.transparent,
                         ),
                         checkColor: Theme.of(context).indicatorColor,
                         onChanged: null,
                         value: state.selectedTags.containsKey(index)
                             ? state.selectedTags[index]
                             : false,
                       ),
                     ),
                   ),
                 ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
