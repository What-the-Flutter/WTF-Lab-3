import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/constants/app_page_icon.dart';

class AddPageBody extends StatefulWidget {
  final TextEditingController controller;
  final Icon? selectedIcon;

  const AddPageBody({
    super.key,
    required this.controller,
    required this.selectedIcon,
  });

  @override
  State<AddPageBody> createState() => _AddPageBodyState();
}

class _AddPageBodyState extends State<AddPageBody> {
  final listIcon = AppPageIcon.listIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  labelText: S.of(context).name_of_the_page,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: listIcon.length,
                  itemBuilder: (context, index) {
                    final element = listIcon[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              AppColors.colorNormalGrey, // inner circle color
                        ),
                        child: IconButton(
                          icon: element,
                          onPressed: () => context
                              .read<HomeCubit>()
                              .changeSelectedIcon(element),
                          color: widget.selectedIcon == element
                              ? AppColors.colorTurquoise
                              : Colors.white,
                          iconSize: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
