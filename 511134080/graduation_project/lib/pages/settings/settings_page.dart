import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fingerprint_protection_page.dart';
import 'general_settings_page.dart';
import 'settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  ListTile _generalTile(BuildContext context) => ListTile(
        iconColor: Theme.of(context).disabledColor,
        leading: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.nature_people,
          ),
        ),
        title: Text(
          'General',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor,
              ),
        ),
        subtitle: Text(
          'Themes & Interface settings',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
              ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {
          context.read<SettingsCubit>().startLoading();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GeneralSettingsPage(),
            ),
          );
        },
      );

  ListTile _securityTile(BuildContext context) => ListTile(
        iconColor: Theme.of(context).disabledColor,
        leading: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.lock,
          ),
        ),
        title: Text(
          'Security',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor,
              ),
        ),
        subtitle: Text(
          'Fingerprint protection',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
              ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {
          context.read<SettingsCubit>().startLoading();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FingerprintProtectionPage(),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: ListView(
            children: [
              _generalTile(context),
              const Divider(),
              _securityTile(context),
              const Divider(),
            ],
          ),
        ),
      );
}
