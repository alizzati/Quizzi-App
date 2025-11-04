import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  /// You can pass the button label either via `text` or `label`.
  /// One of them must be non-null.
  final String _displayText;
  final VoidCallback? onPressed;
  final Color? color;
  final double? width;
  final double height;
  final TextStyle? textStyle;

  const CustomButton({
    Key? key,
    String? text,
    String? label,
    this.onPressed,
    this.color,
    this.width,
    this.height = 50,
    this.textStyle,
  })  : assert(text != null || label != null,
  'Either text or label must be provided'),
        _displayText = text ?? label ?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color background =
        color ?? Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Theme.of(context).primaryColor;
    final Color foreground = ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null ? background : background.withOpacity(0.45),
          foregroundColor: onPressed != null ? (ThemeData.estimateBrightnessForColor(background) == Brightness.dark ? Colors.white : Colors.black87) : Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textStyle ?? const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(_displayText),
      ),
    );
  }
}
