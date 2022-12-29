import 'package:flutter/material.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/constants/app_page_icon.dart';

class AddPageBody extends StatefulWidget {
  final TextEditingController controller;

  const AddPageBody({
    super.key,
    required this.controller,
  });

  @override
  State<AddPageBody> createState() => _AddPageBodyState();
}

class _AddPageBodyState extends State<AddPageBody> {
  final listIcon = AppPageIcon.listIcon;

  @override
  Widget build(BuildContext context) {
    var iconSeleted = AddNewScreen.of(context).selectedIcon;

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
                      color: AppColors.colorNormalGrey, // inner circle color
                    ),
                    child: IconButton(
                      icon: element,
                      onPressed: () {
                        setState(
                          () {
                            if (iconSeleted != element) {
                              iconSeleted = element;
                              AddNewScreen.of(context)
                                  .changeSelectedIcon(iconSeleted);
                            } else if (iconSeleted == element) {
                              iconSeleted = null;
                              AddNewScreen.of(context).changeSelectedIcon(null);
                            }
                          },
                        );
                      },
                      color: iconSeleted == element
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
  }
}
