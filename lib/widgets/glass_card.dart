import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.55),
            Colors.white.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
        // backdropFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
