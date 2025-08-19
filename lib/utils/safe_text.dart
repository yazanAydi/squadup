import 'package:flutter/material.dart';

/// A safe text widget that automatically prevents overflow issues.
/// 
/// This widget wraps text in a Flexible container with maxLines and TextOverflow.ellipsis
/// to ensure text never causes layout overflow.
class SafeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final bool softWrap;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final String? semanticsLabel;

  const SafeText(
    this.text, {
    this.style,
    this.maxLines = 1,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap = true,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionColor,
    this.semanticsLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Avoid forcing Flexible to prevent ParentData conflicts in non-Flex parents
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// A safe text widget for titles that can span multiple lines.
class SafeTitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextAlign? textAlign;

  const SafeTitleText(
    this.text, {
    this.style,
    this.maxLines = 2,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeText(
      text,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// A safe text widget for body text that can span multiple lines.
class SafeBodyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextAlign? textAlign;

  const SafeBodyText(
    this.text, {
    this.style,
    this.maxLines = 3,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeText(
      text,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// A safe text widget for labels that should never overflow.
class SafeLabelText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const SafeLabelText(
    this.text, {
    this.style,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeText(
      text,
      style: style,
      maxLines: 1,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// A safe text widget for buttons that should never overflow.
class SafeButtonText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const SafeButtonText(
    this.text, {
    this.style,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeText(
      text,
      style: style,
      maxLines: 1,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
