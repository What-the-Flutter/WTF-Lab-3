import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/settings_animation.dart';
import 'settings_cubit.dart';

class FingerprintProtectionPage extends StatelessWidget {
  const FingerprintProtectionPage({Key? key}) : super(key: key);

  AppBar _appBar(BuildContext context) => AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'Security',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      );

  Widget _body(BuildContext context, SettingsState state) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8,
        ),
        child: ListView(
          children: [
            _fingerprintTile(context, state),
            const Divider(),
          ],
        ),
      );

  Widget _fingerprintTile(BuildContext context, SettingsState state) =>
      ListTile(
        iconColor: Theme.of(context).disabledColor,
        leading: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.fingerprint,
          ),
        ),
        title: Text(
          'Fingerprint',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor,
              ),
        ),
        subtitle: Text(
          'Enable Fingerprint unlock',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
              ),
        ),
        trailing: Switch(
          value: state.useFingerprint,
          onChanged: context.read<SettingsCubit>().toggleUsingFingerprint,
          activeColor: Theme.of(context).primaryColorLight,
        ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => Scaffold(
          appBar: _appBar(context),
          body: state.isLoaded ? settingsAnimation : _body(context, state),
        ),
      );
}
