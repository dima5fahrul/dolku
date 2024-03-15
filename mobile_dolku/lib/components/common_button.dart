import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.borderColor,
    required this.onTap,
    this.withBorder = true,
    required this.text,
  });

  final Color? borderColor;
  final VoidCallback onTap;
  final bool withBorder;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: withBorder
                ? Border.all(
                    color: borderColor ?? Theme.of(context).colorScheme.primary,
                    width: 1)
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: withBorder
                  ? Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: borderColor)
                  : Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
