import 'package:flutter/material.dart';

class NeuButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const NeuButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
