import 'package:flutter/material.dart';

List<InlineSpan> highlightPattern(String text, String pattern) {
  final List<InlineSpan> textSpans = [];
  int index = 0;
  while (index < text.length) {
    int matchIndex = text.toLowerCase().indexOf(pattern.toLowerCase(), index);
    if (matchIndex == -1) {
      textSpans.add(TextSpan(text: text.substring(index)));
      break;
    } else {
      textSpans.add(TextSpan(text: text.substring(index, matchIndex)));
      textSpans.add(TextSpan(
        text: text.substring(matchIndex, matchIndex + pattern.length),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      index = matchIndex + pattern.length;
    }
  }

  return textSpans;
}
