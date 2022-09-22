import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  const HighlightedText({
    Key? key,
    required this.text,
    required this.query,
    this.highlightColor,
    this.style,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final String query;
  final Color? highlightColor;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    // search query is not empty
    if (query.isNotEmpty) {
      int startIndex = text.toLowerCase().indexOf(query.toLowerCase());
      // text contains searched query
      if (startIndex >= 0) {
        return RichText(
          text: TextSpan(
            text: text.substring(0, startIndex),
            style: style,
            children: [
              TextSpan(
                text: text.substring(startIndex, startIndex + query.length),
                style: style != null
                    ? style!.copyWith(
                        color:
                            highlightColor ?? Theme.of(context).highlightColor)
                    : TextStyle(
                        color:
                            highlightColor ?? Theme.of(context).highlightColor,
                      ),
              ),
              TextSpan(
                text: text.substring(startIndex + query.length),
                style: style,
              )
            ],
          ),
          overflow: overflow ?? TextOverflow.ellipsis,
          maxLines: maxLines,
        );
      }
    }
    // search query is empty
    return RichText(
      text: TextSpan(
        text: text,
        style: style,
      ),
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
