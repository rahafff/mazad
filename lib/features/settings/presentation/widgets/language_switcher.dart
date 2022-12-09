import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/global.dart';
import '../manager/language_cubit.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langContext = context.read<LanguageCubit>();
    return SwitchListTile(
      title: Text(
        AppStrings.language.tr(),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      activeThumbImage: const AssetImage(ImageAssetsManager.englishIcon,),
      inactiveThumbImage: const AssetImage(ImageAssetsManager.arabicIcon),
      activeTrackColor: ColorManager.kMove,
      value: lang,
      onChanged: (newValue) async {
        await langContext.changeLanguage(newValue, context);
      },
    );
  }
}
