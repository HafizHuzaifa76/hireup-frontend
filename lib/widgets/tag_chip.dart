import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;

  const TagChip({
    super.key,
    required this.text,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textColor ?? const Color(0xFF2563EB),
        ),
      ),
    );
  }
}