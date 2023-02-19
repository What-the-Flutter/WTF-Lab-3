import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/theme/theme_cubit.dart';
import '../../../theme/colors.dart';
import '../../../utils/utils.dart';
import '../../pages/archive_page.dart';

class ArchiveRow extends StatelessWidget {
  final String archivedInfo;

  const ArchiveRow({super.key, required this.archivedInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _initArchiveBox(
            child: Icon(
              Icons.archive,
              size: 25,
              color: BlocProvider.of<ThemeCubit>(context).isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          _initArchiveBox(child: Text(archivedInfo)),
        ],
      ),
      onTap: () => openNewPage(context, const ArchivePage()),
    );
  }

  Widget _initArchiveBox({required Widget child}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: circleMessageColor,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Center(child: child),
    );
  }
}
