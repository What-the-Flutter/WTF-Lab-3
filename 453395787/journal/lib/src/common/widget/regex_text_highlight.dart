import 'package:flutter/material.dart';

class RegexTextHighlight extends StatelessWidget {
  const RegexTextHighlight({
    required this.text,
    required this.highlightRegex,
    required this.highlightStyle,
    this.nonHighlightStyle,
  });

  final String text;
  final RegExp highlightRegex;
  final TextStyle highlightStyle;
  final TextStyle? nonHighlightStyle;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text(
        '',
        style: nonHighlightStyle ?? DefaultTextStyle.of(context).style,
      );
    }

    var spans = <TextSpan>[];
    var start = 0;
    while (true) {
      final highlight = highlightRegex.stringMatch(text.substring(start));
      if (highlight == null) {
        // no highlight
        spans.add(_normalSpan(text.substring(start)));
        break;
      }

      final indexOfHighlight = text.indexOf(highlight, start);
      if (indexOfHighlight == start) {
        // starts with highlight
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        // normal + highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    }

    return RichText(
      text: TextSpan(
        style: nonHighlightStyle ?? DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: highlightStyle);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content);
  }
}
