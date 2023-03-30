import 'package:flutter/material.dart';

const decoratedTextColor = Colors.blue;

class HashTag {
  static bool has(String value) {
    final detector = Detector(
        textStyle: const TextStyle(),
        decorStyle: const TextStyle(color: decoratedTextColor));
    final result = detector.getDetections(value);
    final detections = result
        .where((detection) => detection.style!.color == decoratedTextColor)
        .toList();
    return detections.isNotEmpty;
  }

  static List<String> extract(String value) {
    final detector = Detector(
        textStyle: const TextStyle(),
        decorStyle: const TextStyle(color: decoratedTextColor));
    final detections = detector.getDetections(value);
    final taggedDetections = detections
        .where((detection) => detection.style!.color == decoratedTextColor)
        .toList();
    final result = taggedDetections.map((decoration) {
      final text = decoration.range.textInside(value);
      return text.trim();
    }).toList();
    return result;
  }
}

class Detector {
  final TextStyle? textStyle;
  final TextStyle? decorStyle;
  final bool? sign;

  Detector({this.textStyle, this.decorStyle, this.sign = false});

  List<Detection> _getSourceDetections(
      List<RegExpMatch> tags, String copiedText) {
    TextRange? prevItems;
    final result = <Detection>[];
    for (var tag in tags) {
      if (prevItems == null) {
        if (tag.start > 0) {
          result.add(Detection(
              range: TextRange(start: 0, end: tag.start), style: textStyle));
        }
      } else {
        result.add(Detection(
            range: TextRange(start: prevItems.end, end: tag.start),
            style: textStyle));
      }

      result.add(Detection(
          range: TextRange(start: tag.start, end: tag.end), style: decorStyle));
      prevItems = TextRange(start: tag.start, end: tag.end);
    }

    if (result.last.range.end < copiedText.length) {
      result.add(Detection(
          range:
              TextRange(start: result.last.range.end, end: copiedText.length),
          style: textStyle));
    }
    return result;
  }

  List<Detection> getDetections(String text) {
    RegExp regExp;
    if (sign == true) {
      regExp = RegExp(r'''[@|#][^\s!@#$%^&*()=+،\/,\[{\]};:'"?><]+''',
          multiLine: true);
    } else {
      regExp =
          RegExp(r'''#[^\s!@#$%^&*()=+،\/,\[{\]};:'"?><]+''', multiLine: true);
    }

    final tags = regExp.allMatches(text).toList();
    if (tags.isEmpty) {
      return [];
    }
    return _getSourceDetections(tags, text);
  }
}

class Detection extends Comparable<Detection> {
  Detection({required this.range, this.style, this.emojiStartPoint});

  final TextRange range;
  final TextStyle? style;
  final int? emojiStartPoint;

  @override
  int compareTo(Detection other) {
    return range.start.compareTo(other.range.start);
  }
}
