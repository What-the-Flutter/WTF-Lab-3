part of 'chat_icons.dart';

class _SelectableIcon extends StatelessWidget {
  final int index;
  final IconData icon;
  final bool isSelected;
  final void Function(bool isSelected, int index) onTap;

  const _SelectableIcon({
    super.key,
    required this.index,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
            : null,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => onTap(
          isSelected,
          index,
        ),
        child: Icon(
          icon,
        ),
      ),
    );
  }
}
