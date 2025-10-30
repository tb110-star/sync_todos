// lib/presentation/widgets/glass.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class Glass extends StatelessWidget {
  const Glass({
    super.key,
    required this.child,
    this.radius = 20,
    this.padding = const EdgeInsets.all(16),
    this.opacity = 0.15,
    this.borderOpacity = 0.25,
    this.blur = 20,
  });

  final Widget child;
  final double radius;
  final EdgeInsets padding;
  final double opacity;
  final double borderOpacity;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            border: Border.all(color: Colors.white.withOpacity(borderOpacity)),
            borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
