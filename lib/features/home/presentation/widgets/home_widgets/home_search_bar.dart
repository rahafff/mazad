import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/app_validation_functions.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final GlobalKey<FormState> _searchKey = GlobalKey();
  final TextEditingController _searchEditingController =
      TextEditingController();
  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _searchKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: CustomTextFormField(
          controller: _searchEditingController,
          onPressingIcon: () => _goToSearchScreen(context),
          onEditingComplete: () => _goToSearchScreen(context),
          onFieldSubmitted: (value) => _searchEditingController.text = value,
          labelText: AppStrings.search.tr(),
          validator: (value) => AppValidation.validateSearch(value),
          authIcon: Icons.search,
        ),
      ),
    );
  }

  void _goToSearchScreen(BuildContext context) {
    if (_searchKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        Routes.search,
        arguments: SearchArguments(search: _searchEditingController.text),
      );
      Future.delayed(const Duration(seconds: 1), () {
        _searchEditingController.clear();
      });
      FocusScope.of(context).unfocus();
    }
  }
}
