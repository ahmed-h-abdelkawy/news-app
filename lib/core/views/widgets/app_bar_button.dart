import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppBarButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isTransparent;

  const AppBarButton({
    super.key,
    required this.iconData,
    required this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor =
        iconColor ?? (isTransparent ? Colors.white : AppColors.black);

    final effectiveBackgroundColor =
        backgroundColor ??
        (isTransparent ? Colors.white.withValues(alpha: 0.2) : AppColors.grey3);

    Widget buttonContent = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: effectiveBackgroundColor,
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Icon(iconData, color: effectiveIconColor, size: 30),
        ),
      ),
    );

    if (isTransparent) {
      return ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: buttonContent,
        ),
      );
    }

    return ClipOval(child: buttonContent);
  }
}
