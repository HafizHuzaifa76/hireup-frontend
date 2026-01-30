import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, outlined, danger }

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;
  final ButtonVariant variant;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 48,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = const Color(0xFF2563EB);
        foregroundColor = Colors.white;
        borderColor = const Color(0xFF2563EB);
        break;
      case ButtonVariant.secondary:
        backgroundColor = const Color(0xFFF1F5F9);
        foregroundColor = const Color(0xFF475569);
        borderColor = const Color(0xFFF1F5F9);
        break;
      case ButtonVariant.outlined:
        backgroundColor = Colors.transparent;
        foregroundColor = const Color(0xFF2563EB);
        borderColor = const Color(0xFF2563EB);
        break;
      case ButtonVariant.danger:
        backgroundColor = const Color(0xFFFEF2F2);
        foregroundColor = const Color(0xFFDC2626);
        borderColor = const Color(0xFFFCA5A5);
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: borderColor,
              width: variant == ButtonVariant.outlined ? 2 : 0,
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}