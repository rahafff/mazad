import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../resources/color_manager.dart';
import '../utils/global.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.obscureText = false,
    this.readOnly = false,
    this.onPressingIcon,
    this.keyBoardType = TextInputType.text,
    required this.validator,
    required this.labelText,
    this.authIcon,
    required this.controller,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.textFieldBorderRadius,
    this.prefixText = "", this.onChanged, this.onTap,
  }) : super(key: key);
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onPressingIcon;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  /// put max lines to null if you want infinite lines and keyboard input type to multiline
  final TextInputType keyBoardType;
  final String? Function(String? val)? validator;
  final String labelText;
  final String prefixText;
  final IconData? authIcon;
  final int? maxLength;

  /// put max lines to null if you want infinite lines and keyboard input type to multiline
  final int? maxLines;
  final TextInputAction? textInputAction;
  final double? textFieldBorderRadius;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      validator: validator,
      textAlign: TextAlign.start,
      textInputAction: textInputAction,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines,
      obscuringCharacter: '*',
      scrollPadding: const EdgeInsets.all(0),
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      textDirection: lang ?TextDirection.ltr:TextDirection.rtl,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        isDense: true,
        counterText: "",
        prefix: Text(
          prefixText,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        suffixIcon: IconButton(
          onPressed: onPressingIcon,
          icon: Icon(
            authIcon,
            color: ColorManager.kGreen,
          ),
        ),
        labelText: labelText,
      ),
    );
  }
}
