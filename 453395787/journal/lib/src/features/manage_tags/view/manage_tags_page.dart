import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/data/repository/tag_repository.dart';
import '../../../common/features/theme/theme.dart';
import '../../../common/models/ui/tag.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../../routes.dart';
import '../../chat/chat.dart';
import '../cubit/manage_tags_cubit.dart';

part '../widget/selection_tag_page_body.dart';

part '../widget/add_edit_tag_page_body.dart';

class ManageTagsPage extends StatelessWidget {
  const ManageTagsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageTagsCubit(
        tagRepository: context.read<TagRepository>(),
      ),
      child: BlocBuilder<ManageTagsCubit, ManageTagsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                locale.Pages.tagsManage.i18n(),
              ),
              leading: BackButton(
                onPressed: () {
                  state.maybeMap(
                    initial: (initial) {
                      context.go(
                        Navigation.settingsPagePath,
                      );
                    },
                    orElse: () {
                      context.read<ManageTagsCubit>().backToDefault();
                    },
                  );
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(Insets.large),
              child: Builder(
                builder: (context) {
                  return state.map(
                    initial: (initial) {
                      return _SelectionTagPageBody(
                        tags: initial.tags,
                      );
                    },
                    addModeState: (addModeState) {
                      return _AddEditTagPageBody(
                        tagForEdit: addModeState.newTag,
                      );
                    },
                    editModeState: (editModeState) {
                      return _AddEditTagPageBody(
                        tagForEdit: editModeState.editableTag,
                      );
                    },
                    selectModeState: (selectModeState) {
                      return _SelectionTagPageBody(
                        tags: selectModeState.tags,
                        selectedId: selectModeState.selectedTag,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
