import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
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
  })  : assert(text != null || label != null, 'text or label required'),
        _displayText = text ?? label ?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color background =
        color ?? Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Theme.of(context).primaryColor;
    final bool enabled = onPressed != null;
    final Color fg = ThemeData.estimateBrightnessForColor(background) == Brightness.dark ? Colors.white : Colors.black87;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? background : background.withOpacity(0.45),
          foregroundColor: enabled ? fg : Colors.white70,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(_displayText, style: textStyle),
      ),
    );
  }
}
