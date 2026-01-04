import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final Color? iconColor;
  final Widget? leading;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    this.iconColor,
    this.leading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = color.computeLuminance() > 0.5;
    final resolvedTextColor = isLight ? Colors.black : Colors.white;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side:
              color == Colors.white
                  ? BorderSide(color: Colors.grey.shade600)
                  : null,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child:
                  leading ??
                  Icon(icon, size: 32, color: iconColor ?? resolvedTextColor),
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: resolvedTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
