import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final String? hint;
  final Function(String)? onChanged;

  final int? minLines;
  final int? maxLines;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.hint,
    this.onChanged,
    this.minLines,
    this.maxLines,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hide = true;

  @override
  void initState() {
    super.initState();
    hide = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isPassword = widget.obscure;
    final int? minL = isPassword ? 1 : widget.minLines;
    final int? maxL = isPassword ? 1 : widget.maxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),

        Container(
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: isPassword ? hide : false,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            minLines: minL,
            maxLines: maxL,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintText: widget.hint,
              border: InputBorder.none,

              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(widget.prefixIcon, size: 22),

              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  hide ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => hide = !hide),
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
