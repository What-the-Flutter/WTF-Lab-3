import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import 'settings_cubit.dart';

class BackgroundChatImage extends StatelessWidget {
  const BackgroundChatImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(local?.backgroundImage ?? ''),
      ),
      body: Center(
        child: context.watch<SettingsCubit>().state.backgroundImage == ''
            ? _noBackgroundImage(context, local)
            : _showBackgroundImage(context, local),
      ),
    );
  }

  Widget _noBackgroundImage(BuildContext context, AppLocalizations? local) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            local?.setBackgroundLabel ?? '',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            child: Text(local?.setBackground ?? ''),
            onPressed: () async => await _pickImage(context),
          ),
        ],
      ),
    );
  }

  Widget _showBackgroundImage(BuildContext context, AppLocalizations? local) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: Image.file(
            File(context.watch<SettingsCubit>().state.backgroundImage),
          ),
        ),
        ListTile(
          title: Text(
              local?.cancelBackground ?? ''
          ),
          leading: const Icon(Icons.delete),
          onTap: () => context.read<SettingsCubit>().setBackgroundImage(''),
        ),
        ListTile(
          title: Text(
              local?.setBackground ?? ''
          ),
          leading: const Icon(Icons.image),
          onTap: () async => await _pickImage(context),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final media = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (media != null) {
      final imagePath = media.path;
      context.read<SettingsCubit>().setBackgroundImage(imagePath);
    }
  }
}
