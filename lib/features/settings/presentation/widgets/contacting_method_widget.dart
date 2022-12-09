import 'package:flutter/material.dart';

class ContactingMethod extends StatelessWidget {
  const ContactingMethod({
    Key? key,
    required this.methodTitle,
    required this.methodContent,
    required this.onTappingMethod,
  }) : super(key: key);
  final String methodTitle;
  final String methodContent;
  final VoidCallback onTappingMethod;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(methodTitle),
        GestureDetector(onTap: onTappingMethod, child: Text(methodContent)),
      ],
    );
  }
}
