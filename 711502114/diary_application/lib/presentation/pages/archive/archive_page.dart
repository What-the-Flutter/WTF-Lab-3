import 'package:diary_application/presentation/pages/home/home_cubit.dart';
import 'package:diary_application/presentation/pages/home/home_state.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/presentation/widgets/home_page/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local?.archiveChat ?? ''),
        centerTitle: true,
      ),
      body: _createMessagesList(),
    );
  }

  Widget _createMessagesList() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (cubitContext, state) {
        final chats = state.chats.where((c) => c.isArchive).toList();

        return ListView.separated(
          itemCount: chats.length,
          itemBuilder: (_, i) {
            return ChatCard(
              chat: chats[i],
              widget: _initArchiveButton(cubitContext, chats[i].id),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 1);
          },
        );
      },
    );
  }

  Widget _initArchiveButton(BuildContext context, String id) {
    final color = BlocProvider.of<SettingsCubit>(context).isDark
        ? Colors.white
        : Colors.black;
    return IconButton(
      onPressed: () => context.read<HomeCubit>().archive(id, false),
      icon: Icon(Icons.archive, color: color),
    );
  }
}
