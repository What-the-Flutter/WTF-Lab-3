part of 'message_item.dart';

class _MessageText extends StatelessWidget {
  const _MessageText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.medium,
        top: Insets.medium,
        right: Insets.medium,
        bottom: Insets.none,
      ),
      child: Text(
        text,
      ),
    );
  }
}

class _MessageTime extends StatelessWidget {
  const _MessageTime({
    super.key,
    required this.time,
  });

  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        Insets.extraSmall,
      ),
      child: Text(
        time,
        style: TextStyles.defaultGrey(context),
      ),
    );
  }
}
