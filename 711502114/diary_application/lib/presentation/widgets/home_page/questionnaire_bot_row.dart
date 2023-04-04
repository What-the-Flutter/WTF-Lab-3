import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class QuestionnaireBot extends StatelessWidget {
  const QuestionnaireBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: botBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/bot.svg',
                height: 25, width: 25, color: Colors.grey[600]),
            const SizedBox(width: 28),
            Text(
              AppLocalizations.of(context)?.bot ?? '',
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
