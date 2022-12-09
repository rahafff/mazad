import 'dart:async';

import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/loading_circular.dart';

class SignUpLoadingScreen extends StatefulWidget {
  const SignUpLoadingScreen({Key? key}) : super(key: key);

  @override
  State<SignUpLoadingScreen> createState() => _SignUpLoadingScreenState();
}

class _SignUpLoadingScreenState extends State<SignUpLoadingScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, Routes.verificationCodeRoute);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: LoadingCircularWidget(),
        ),
      ),
    );
  }
}
