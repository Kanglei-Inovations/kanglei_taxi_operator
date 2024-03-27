import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? letterSpacing;
  final int? maxLine;
  final bool? softWrap;
  final TextOverflow? overflow;
  final VoidCallback? onClick;
  final FontStyle? fontStyle;

  const AppText({
    Key? key,
    required this.text,
    this.size = 16,
    this.fontWeight,
    this.color,
    this.fontStyle,
    this.fontFamily,
    this.wordSpacing,
    this.letterSpacing,
    this.maxLine,
    this.softWrap,
    this.textAlign,
    this.overflow,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(
              text,
              softWrap: softWrap,
              textAlign: textAlign,
              overflow: overflow,
              maxLines: maxLine,
              style: TextStyle(
                fontStyle: fontStyle,
                fontSize: size,
                fontWeight: fontWeight,
                color: color,
                fontFamily: fontFamily,
                wordSpacing: wordSpacing,
                letterSpacing: letterSpacing,
              ),
            )
          : TextButton(
              onPressed: () {
                onClick;
              },
              child: Text(
                text,

                style: TextStyle(
                  fontSize: size,
                  fontWeight: fontWeight,
                  color: color,
                  wordSpacing: wordSpacing,
                ),
              ),
            ),
    );
  }
}
