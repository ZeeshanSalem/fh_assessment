import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.filledColor = Colors.white,
    this.label,
    this.controller,
    this.hintTextStyle,
    this.textStyle,
    this.borderSide = BorderSide.none,
    this.hintText,
    this.constraints,
    this.suffixConstraints,
    this.maxLength = 256,
    this.maxLines = 1,
    this.readOnly = false,
    this.isNumeric = false,
    this.isPhoneNumber = false,
    this.isDecimalAllowed = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onTap,
    this.contentPadding,
    this.isObscure = false,
    this.autoFocus = false,
    this.labelWidget,
    this.onEditingComplete,
    this.onChanged,
    this.isRounded = false,
    this.borderRadius = 15.0,
    this.border,
    this.keyboardType = TextInputType.text,
    this.focusNode,
  });

  final String? label;
  final Color filledColor;
  final BorderSide borderSide;
  final double borderRadius;
  final TextEditingController? controller;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final String? hintText;
  final bool readOnly;
  final bool isNumeric;
  final InputBorder? border;
  final TextInputType keyboardType;
  final bool isPhoneNumber;
  final bool autoFocus;
  final bool isObscure;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? constraints;
  final BoxConstraints? suffixConstraints;
  final bool isDecimalAllowed;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? labelWidget;
  final VoidCallback? onTap;
  final int? maxLength;
  final int? maxLines;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool isRounded;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        if (label != null)
          Text(
            label!,
            style: AppTypography.lightTheme.titleMedium,
          ),
        TextFormField(
          maxLines: maxLines,
          focusNode: focusNode,
          autofocus: autoFocus,
          obscureText: isObscure,
          onTap: onTap,
          controller: controller,
          keyboardType: isNumeric
              ? TextInputType.numberWithOptions(decimal: isDecimalAllowed)
              : keyboardType,
          readOnly: readOnly,
          maxLength: maxLength,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          validator: validator,
          style: textStyle ?? AppTypography.lightTheme.bodyMedium,
          decoration: InputDecoration(
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: borderSide,
                ),
            enabledBorder: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: borderSide,
                ),
            focusedBorder: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: borderSide,
                ),
            errorBorder: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: const BorderSide(color: Colors.red),
                ),
            fillColor: filledColor,
            filled: true,
            hintText: hintText,
            hintStyle: AppTypography.lightTheme.titleSmall,
            prefixIcon: prefixIcon,
            prefixIconConstraints: constraints,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixConstraints,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
