import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_cubit.dart';

class ChoosingBackgroundImage extends StatelessWidget {
  const ChoosingBackgroundImage({Key? key}) : super(key: key);

  Widget _settingImage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240,
            child: Text(
              'Click the button below to set the Background Image',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          TextButton(
            onPressed: () {
              context.read<SettingsCubit>().pickBackgroundImage();
            },
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).primaryColorLight.withOpacity(0.8),
              side: const BorderSide(
                width: 1.0,
              ),
            ),
            child: Text(
              'Pick an Image',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewBackgroundImage(BuildContext context, SettingsState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 16,
        ),
        Image.file(
          File(
            state.backgroundImage,
          ),
        ),
        ListTile(
          iconColor: Theme.of(context).disabledColor,
          leading: const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
            ),
          ),
          title: Text(
            'Unset Image',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
          ),
          onTap: () {
            context.read<SettingsCubit>().unsetBackgroundImage();
          },
        ),
        ListTile(
          iconColor: Theme.of(context).disabledColor,
          leading: const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.photo,
            ),
          ),
          title: Text(
            'Pick a new Image',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
          ),
          onTap: () {
            context.read<SettingsCubit>().pickBackgroundImage();
          },
        ),
      ],
    );
  }

  Widget _body(BuildContext context, SettingsState state) {
    if (state.backgroundImage == '') {
      return _settingImage(context);
    } else {
      return _previewBackgroundImage(context, state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            centerTitle: true,
            title: Text(
              'Background Image',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: _body(context, state),
        );
      },
    );
  }
}
