import 'package:flutter/material.dart';

class CommonForm extends StatefulWidget {
  const CommonForm({
    super.key,
    required this.controller,
    this.focusedColor,
    this.hintText,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final Color? focusedColor;
  final String? hintText;
  final bool isPassword;

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      autocorrect: widget.isPassword ? false : true,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: widget.hintText ?? '',
        focusColor:
            widget.focusedColor ?? Theme.of(context).colorScheme.primary,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onTap: () => setState(() => _obscureText = !_obscureText),
              )
            : null,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color:
                  widget.focusedColor ?? Theme.of(context).colorScheme.primary,
              width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color:
                  widget.focusedColor ?? Theme.of(context).colorScheme.primary,
              width: 1),
        ),
      ),
    );
  }
}
