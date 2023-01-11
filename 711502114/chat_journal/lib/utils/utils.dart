String formatTime(DateTime time, {bool includeSec = true}) {
  final hours = time.hour;
  final hour = hours < 10 ? '0$hours' : '$hours';

  final minutes = time.minute;
  final min = minutes < 10 ? '0$minutes' : '$minutes';

  return '$hour:$min${_addSeconds(time.second, includeSec)}';
}

String _addSeconds(int seconds, bool include) {
  if (!include) return '';
  final sec = seconds < 10 ? '0$seconds' : '$seconds';
  return ':$sec';
}
